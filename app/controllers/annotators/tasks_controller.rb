# frozen_string_literal: true

module Annotators
  class TasksController < BaseController
    def assigned
      @tasks = policy_scope(Task)
    end

    def completed
      @tasks = policy_scope(Task)
    end

    def complete
      # TODO: implement with warnign one time completion
    end
  end
end
