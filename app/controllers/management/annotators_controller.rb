# frozen_string_literal: true

module Management
  class AnnotatorsController < BaseController
    include CrudActions

    private

    def post_params
      params.require(:annotator).permit(:email, :fullname)
    end

    def search_params
      { editor_id_eq: current_editor.id }.merge(
        params[:search]&.permit(
          :email_eq,
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
