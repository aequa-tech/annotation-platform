module Api
  module V1
    class AnnotationsController < ApplicationController
      before_action :text_line

      def create
        @annotation = Annotation.new(
          content: annotation_params,
          text_line: text_line,
          annotator: current_annotator
        )

        if @annotation.save
          render json: @annotation, status: :created
        else
          render json: @annotation.errors, status: :unprocessable_entity
        end
      end

      def index
        @annotations = current_annotator.annotations.where(text_line_id: text_line).pluck(:content)

        render json: @annotations
      end

      private

      def annotation_params
        params[:annotation]
      end

      def text_line
        @text_line = TextLine.find(params[:text_line_id])
      end
    end
  end
end
