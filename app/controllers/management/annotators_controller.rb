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
    rescue ActiveRecord::RecordNotUnique
      flash.now[:alert] = t("infold.flash.invalid")
      render :form, status: :unprocessable_entity
    end

    def import
      # Questo metodo mostrerà il modulo per l'importazione di annotatori da un file CSV
      @import_csv = Management::ImportCsv.new(klass: Annotator)
    end

    def import_csv
      # Questo metodo gestirà l'importazione effettiva degli annotatori da un file CSV
      permitted_params = params.dig(:management_import_csv) ? params.require(:management_import_csv).permit(:csv_file) : {}
      @import = Management::ImportCsv.new(klass: Annotator, csv_file: permitted_params[:csv_file])

      if @import.valid?
        CSV.foreach(@import.csv_file.tempfile, headers: true, header_converters: [:downcase, :symbol]) do |row|
          ImportAnnotatorsJob.perform_later(current_editor.id, email: row[:email], fullname: row[:fullname])
        end
        flash[:notice] = t("infold.flash.queued_invites")
      else
        flash[:alert] = t("infold.flash.invalid")
      end

      redirect_to management_annotators_path
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
