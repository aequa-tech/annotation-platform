# frozen_string_literal: true

module Annotators
  class TasksController < BaseController
    def assigned
      @search = TaskSearchForm.new(search_params)
      scope = policy_scope(Task)
      @tasks = @search.perform(scope, params[:page], limit: 25, csv: request.format == :csv)
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

    def completed
      @tasks = policy_scope(Task)
    end

    def complete
      # TODO: implement with warnign one time completion
    end
  end
end
