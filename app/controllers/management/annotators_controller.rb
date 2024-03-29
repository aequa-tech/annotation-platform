# frozen_string_literal: true

module Management
  class AnnotatorsController < BaseController
    include CrudActions

    private

    def post_params
      permitted_params.merge(editor_id: current_editor.id)
    end

    def permitted_params
      params.require(:management_annotator).permit(:email, :fullname, :password)
    end

    def search_params
      { editor_id_eq: current_editor.id }.merge(
        params[:search]&.permit(
          :id_eq,
          :email_full_like,
          :fullname_full_like,
          :sort_field,
          :sort_kind
        ).to_h
      )
    end

    def klass
      Annotator
    end

    def search_form_klass
      AnnotatorSearchForm
    end
  end
end
