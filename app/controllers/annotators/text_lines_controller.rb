# frozen_string_literal: true

module Annotators
  class TextLinesController < BaseController
    before_action :set_task, only: %i[index show]

    def show
      authorize @task, :assigned?
      @text_line = @task.text_lines.find(params[:id])
    end

    def index
      authorize @task, :assigned?

      @search = TextLineSearchForm.new(search_params)
      scope = @task.text_lines.order(position: :asc)
      @text_lines = @search.perform(scope, params[:page], limit: 25, csv: request.format == :csv)
    end

    private

    def set_task
      @task = ::Task.find(params[:task_id])
    end

    def search_params
      params[:search]&.permit(
        :id_eq,
        :lines_set_id_eq,
        :corpus_id_eq,
        :sort_field,
        :sort_kind
      ).to_h
    end
  end
end
