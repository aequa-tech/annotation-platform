module Api
  module V1
    class TaxonomiesController < ApplicationController
      before_action :task, only: %i[index]

      def index
        authorize task, :assigned?

        @taxonomies = task.corpus.taxonomies

        render json: @taxonomies
      end

      private

      def task
        @task = Task.find(params[:task_id])
      end
    end
  end
end
