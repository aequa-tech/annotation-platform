# frozen_string_literal: true

module Management
  class LinesSetsController < BaseController
    before_action :set_corpus

    def index
      authorize @corpus, :show?

      @search = search_form_klass.new({ corpus_id_eq: @corpus.id }.merge(search_params.to_h))
      @resources = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
    end

    def show
      @resource = klass.find(params[:id])
    end

    def edit
      @resource = klass.find(params[:id])
    end

    def update
      @resource = klass.find(params[:id])
      @resource.assign_attributes(post_params)
      tasks_attributes = post_params[:task_annotator_ids].inject([]) do |acc, annotator_id|
        acc << { annotator_id: annotator_id }
      end

      if @resource.save && @resource.tasks.insert_all(tasks_attributes, unique_by: :index_tasks_on_annotator_id_and_lines_set_id)
        flash.now[:notice] = t("infold.flash.updated")
        render :form
      else
        flash.now[:alert] = t("infold.flash.invalid")
        render :form, status: :unprocessable_entity
      end
    end

    private

    def post_params
      params.require(:management_lines_set).permit(:title, task_annotator_ids: [])
    end

    def search_params
      params[:search]&.permit(
        :title_eq,
        :sort_field,
        :sort_kind
      )
    end

    def klass
      LinesSet
    end

    def search_form_klass
      LinesSetSearchForm
    end

    def set_corpus
      @corpus = Corpus.find(params[:corpus_id])
    end
  end
end
