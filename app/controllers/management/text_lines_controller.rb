# frozen_string_literal: true

module Management
  class TextLinesController < BaseController
    before_action :set_corpus

    def index
      authorize @corpus, :show?

      @search = search_form_klass.new({ corpus_id_eq: @corpus.id }.merge(search_params.to_h))
      @resources = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
      @resources = @resources.where(lines_set_id: params[:lines_set_id]) if params[:lines_set_id].present?
    end

    def show
      @resource = klass.find(params[:id])
    end

    private

    def search_params
      params[:search]&.permit(
        :external_id_eq,
        :content_full_like,
        :position_eq,
        :sort_field,
        :sort_kind
      )
    end

    def klass
      TextLine
    end

    def search_form_klass
      TextLineSearchForm
    end

    def set_corpus
      @corpus = Corpus.find(params[:corpus_id])
    end
  end
end
