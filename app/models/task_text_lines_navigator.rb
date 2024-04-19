# frozen_string_literal: true

class TaskTextLinesNavigator
  attr_reader :current

  def initialize(text_lines, current)
    @text_lines = text_lines
    @current = current
  end

  def first
    @text_lines.order(position: :asc).first
  end

  def prev
    @text_lines.where("position < ?", @current.position).order(position: :desc).first
  end

  def next
    @text_lines.where("position > ?", @current.position).order(position: :asc).first
  end

  def last
    @text_lines.order(position: :desc).first
  end

  def current_position
    @text_lines.order(position: :asc).pluck(:position).index(@current.position) + 1
  end

  def total
    @total ||= @text_lines.count
  end

  def first?
    @current == first
  end

  def last?
    @current == last
  end
end
