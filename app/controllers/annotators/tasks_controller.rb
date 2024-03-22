# frozen_string_literal: true

module Annotators
  class TasksController < ApplicationController
    def assigned
      @tasks = current_annotator.tasks
    end
  end
end
