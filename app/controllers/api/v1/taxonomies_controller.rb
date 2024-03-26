module Api
  module V1
    class TaxonomiesController < ApplicationController
      before_action :task, only: %i[index]

      def index
        @taxonomies = task.corpus.taxonomies

        render json: @taxonomies
      end

      private

      def task
        @task = TextLine.find(params[:task_id])
      end
    end
  end
end
