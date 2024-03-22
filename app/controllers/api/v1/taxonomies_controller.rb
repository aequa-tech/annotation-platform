module Api
  module V1
    class TaxonomiesController < ApplicationController
      before_action :text_line, only: %i[index]

      def index
        @taxonomies = text_line.corpus.taxonomies

        render json: @taxonomies
      end

      private

      def text_line
        @text_line = TextLine.find(params[:text_line_id])
      end
    end
  end
end
