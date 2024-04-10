# frozen_string_literal: true

module Management
  class AnnotatorsController < BaseController
    include CrudActions
    require "csv"

    def create
      @resource = klass.new
      @resource.assign_attributes(post_params)
      if @resource.invite!
        flash.now[:notice] = t("infold.flash.created")
        render :form
      else
        flash.now[:alert] = t("infold.flash.invalid")
        render :form, status: :unprocessable_entity
      end
    end

    def import
      # Questo metodo mostrerà il modulo per l'importazione di annotatori da un file CSV
    end

    def import_csv
      # Questo metodo gestirà l'importazione effettiva degli annotatori da un file CSV
      csv_file = params.require(:annotator).permit(:annotators_csv)[:annotators_csv].read

      CSV.parse(csv_file, headers: true) do |row|
        Annotator.invite!(email: row["email"], fullname: row["fullname"], editor_id: current_editor.id)
      end

      redirect_to management_annotators_path, notice: t("infold.flash.invited")
    end

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
