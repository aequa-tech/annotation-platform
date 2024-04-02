module Api
  module V1
    class TextLinesController < ApplicationController
      before_action :task, only: %i[show]

      def show
        authorize task, :assigned?

        @text_line = task.text_lines.find(params[:id])

        render :show
      end

      private

      def task
        @task = Task.find(params[:task_id])
      end
    end
  end
end
