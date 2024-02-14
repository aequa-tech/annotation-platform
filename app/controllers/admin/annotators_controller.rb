module Admin
  class AnnotatorsController < BaseController
    before_action { @page_title = "ANNOTATORS" }

    def index
      @search = AnnotatorSearchForm.new(search_params)
      @annotators = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @annotator = Annotator.find(params[:id])
    end

    def new
      @annotator = Annotator.new
    end

    def create
      @annotator = Annotator.create(post_params)
      if @annotator.persisted?
        flash.now[:notice] = t("infold.flash.created")
        render :form
      else
        flash.now[:alert] = t("infold.flash.invalid")
        render :form, status: :unprocessable_entity
      end
    end

    def edit
      @annotator = Annotator.find(params[:id])
    end

    def update
      @annotator = Annotator.find(params[:id])
      if @annotator.update(post_params)
        flash.now[:notice] = t("infold.flash.updated")
        render :form
      else
        flash.now[:alert] = t("infold.flash.invalid")
        render :form, status: :unprocessable_entity
      end
    end

    def destroy
      @annotator = Annotator.find(params[:id])
      if @annotator.destroy
        redirect_to admin_annotators_path, status: :see_other, flash: { notice: t("infold.flash.destroyed") }
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
        :email_full_like,
        :editor_id_eq,
        :sort_field,
        :sort_kind
      )
    end

    def post_params
      params.require(:admin_annotator).permit(
        :fullname,
        :email,
        :editor_id
      )
    end
  end
end
