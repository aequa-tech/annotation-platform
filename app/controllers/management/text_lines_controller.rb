# frozen_string_literal: true

module Management
  class TextLinesController < BaseController
    before_action :set_corpus

    def index
      @search = search_form_klass.new(search_params)
      @resources = @search.perform(params[:page], limit: params[:limit], csv: request.format == :csv)
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
      @corpus = ::Corpus.find(params[:corpus_id])
    end
  end
end
