# frozen_string_literal: true

module Management
  class TasksController < BaseController
    layout false
    before_action :task, only: :show

    def show
      render :show
    end

    private

    def task
      @task ||= ::Task.find(params[:id])
    end
  end
end
