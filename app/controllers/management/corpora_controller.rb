# frozen_string_literal: true

module Management
  class CorporaController < BaseController
    include CrudActions

    after_action :create_text_lines, only: :create

    private

    def post_params
      permitted_params.merge(editor_id: current_editor.id)
    end

    def permitted_params
      params.require(:management_corpus).permit(:title, :input_file, :remove_input_file, taxonomy_ids: [])
    end

    def search_params
      params[:search]&.permit(
        :id_eq,
        :title_full_like,
        :editor_id_eq,
        :sort_field,
        :sort_kind
      )
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
      ImportCsvJob.perform_later(blob_key, @resource.id)
    end
  end
end
