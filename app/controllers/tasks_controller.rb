# frozen_string_literal: true

class TasksController < ApplicationController
  def assigned
    @tasks = TextLine.all
  end

  def completed
  end
end
