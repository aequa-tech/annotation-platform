# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
  def assigned?
    user.tasks.include?(record)
  end

  def complete?
    assigned? && !record.completed?
  end

  def undo?
    user.is_a?(Editor) && user.annotators.include?(@record.annotator)
  end

  def annotable?
    assigned? && !record.completed?
  end

  class Scope < Scope
    def resolve
      scope.where(annotator: user)
    end
  end
end
