# frozen_string_literal: true

class TasksController < ApplicationController
  def assigned
    @tasks = current_annotator.tasks
  end
end
