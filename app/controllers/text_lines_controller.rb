# frozen_string_literal: true

class TextLinesController < ApplicationController
  before_action :set_task, only: %i[index show]

  def show
    @text_line = TextLine.find(params[:id])
  end

  def index
    @text_lines = @task.text_lines.includes(:tasks).order(position: :asc)
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end
end
