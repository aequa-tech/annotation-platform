# frozen_string_literal: true

module Annotators
  class TasksController < BaseController
    def assigned
      @search = TaskSearchForm.new(search_params)
      scope = policy_scope(Task.incompleted)
      @tasks = @search.perform(scope, params[:page], limit: 25, csv: request.format == :csv)
    end

    def completed
      @search = TaskSearchForm.new(search_params)
      scope = policy_scope(Task.completed)
      @tasks = @search.perform(scope, params[:page], limit: 25, csv: request.format == :csv)
    end

    def complete
      @task = Task.find(params[:id])
      authorize @task

      @task.complete!

      render json: { status: :ok, redirect: request.referrer, notice: "Task completed" }
    rescue Pundit::NotAuthorizedErrors
      render json: { status: :forbidden, redirect: request.referrer, alert: "You are not authorized to complete this task" }
    end

    private

    def search_params
      { annotator_id_eq: current_annotator.id }.merge(
        params[:search]&.permit(
          :id_eq,
          :lines_set_id_eq,
          :sort_field,
          :sort_kind
        ).to_h
      )
    end
  end
end
