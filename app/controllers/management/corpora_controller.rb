# frozen_string_literal: true

module Management
  class CorporaController < BaseController
    include CrudActions

    after_action :create_text_lines, only: :create

    def edit_lines_sets_count
      @resource = Corpus.find(params[:id])
    end

    def manage_sets
      @resource = Corpus.find(params[:id])
      @resource.lines_sets_count = params[:management_corpus][:lines_sets_count]
      @resource.lines_sets.insert_all!(lines_sets_attributes)

      AssignTextLinesToSetsJob.perform_later(@resource.id, @resource.lines_sets_count)

      redirect_to [@resource, :lines_sets], flash: { notice: t("infold.flash.created") }
    rescue ActiveRecord::RecordNotUnique
      flash.now[:alert] = t("infold.flash.invalid")
      render :show, status: :unprocessable_entity
    end

    private

    def post_params
      permitted_params.merge(editor_id: current_editor.id)
    end

    def permitted_params
      params.require(:management_corpus).permit(:title, :input_file, :remove_input_file, taxonomy_ids: [])
    end

    def search_params
      { editor_id_eq: current_editor.id }.merge(params[:search]&.permit(
        :id_eq,
        :title_full_like,
        :editor_id_eq,
        :sort_field,
        :sort_kind
      ).to_h)
    end

    def klass
      Corpus
    end

    def search_form_klass
      CorpusSearchForm
    end

    def create_text_lines
      return unless @resource.input_file.attached?

      blob_key = @resource.input_file.key
      ImportCsvJob.perform_later(current_editor.id, blob_key, @resource.id)
    end

    def lines_sets_attributes
      quotient, modulus = @resource.text_lines.count.divmod(@resource.lines_sets_count.to_i)
      range = modulus.zero? ? (0...quotient) : (0...quotient + 1)

      range.inject([]) do |memo, n|
        memo << { title: "Set ##{n + 1}" }
      end
    end
  end
end
