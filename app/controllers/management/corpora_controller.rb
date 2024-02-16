# frozen_string_literal: true

module Management
  class CorporaController < BaseController
    include CrudActions

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
  end
end
