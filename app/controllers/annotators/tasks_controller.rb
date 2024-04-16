# frozen_string_literal: true

module Annotators
  class TasksController < BaseController
    def assigned
      @tasks = policy_scope(Task)
    end
  end
end
