# frozen_string_literal: true

module Annotators
  class TextLinesController < BaseController
    before_action :set_task, only: %i[index show]

    def show
      authorize @task, :assigned?
      @text_line = @task.text_lines.find(params[:id])
    end

    def index
      authorize @task, :assigned?
      @text_lines = @task.text_lines.includes(:tasks).order(position: :asc)
    end

    private

    def set_task
      @task = ::Task.find(params[:task_id])
    end
  end
end
