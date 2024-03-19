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

      def update
        @annotation = current_annotator.annotations
          .where(text_line_id: text_line.id)
          .find_by("content @> ?", { id: annotation_params[:id] }.to_json)

        if @annotation.update(content: annotation_params)
          render json: @annotation
        else
          render json: @annotation.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @annotation = current_annotator.annotations
          .where(text_line_id: text_line.id)
          .find_by("content @> ?", { id: annotation_params[:id] }.to_json)

        if @annotation.destroy
          head :no_content
        else
          render json: @annotation.errors, status: :unprocessable_entity
        end
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
