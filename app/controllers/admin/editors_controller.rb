module Admin
  class EditorsController < BaseController
    before_action { @page_title = "EDITORS" }

    def index
      @search = EditorSearchForm.new(search_params)
      @editors = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @editor = Editor.find(params[:id])
    end

    def new
      @editor = Editor.new
    end

    def create
      @editor = Editor.new
      @editor.assign_attributes(post_params)
      if @editor.save
        flash.now[:notice] = t("infold.flash.created")
        render :form
      else
        flash.now[:alert] = t("infold.flash.invalid")
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @editor = Editor.find(params[:id])
    end

    def update
      @editor = Editor.find(params[:id])
      @editor.assign_attributes(post_params)
      if @editor.save
        flash.now[:notice] = t("infold.flash.updated")
        render :form
      else
        flash.now[:alert] = t("infold.flash.invalid")
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @editor = Editor.find(params[:id])
      if @editor.destroy
        redirect_to admin_editors_path, status: :see_other, flash: { notice: t("infold.flash.destroyed") }
      else
        flash.now[:alert] = t("flash.invalid_destroy")
        render :show, status: :unprocessable_entity
      end
    end

    private

    def search_params
      params[:search]&.permit(
        :id_eq,
        :fullname_full_like,
        :sort_field,
        :sort_kind
      )
    end

    def post_params
      params.require(:admin_editor).permit(
        :fullname,
        :email
      )
    end
  end
end
