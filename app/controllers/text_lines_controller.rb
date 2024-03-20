# frozen_string_literal: true

class TextLinesController < ApplicationController
  before_action :set_task

  def show
    @text_line = TextLine.find(params[:id])
  end

  def index
    @text_lines = @task.text_lines.order(position: :asc)
  end

  private

  def set_task
    @task = Task.find(params[:task_id])
  end
end
