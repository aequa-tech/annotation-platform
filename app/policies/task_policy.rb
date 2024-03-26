# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
  def assigned?
    user.tasks.include?(record)
  end

  class Scope < Scope
    def resolve
      scope.where(annotator: user)
    end
  end
end
