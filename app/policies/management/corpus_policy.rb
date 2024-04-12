# frozen_string_literal: true

module Management
  class CorpusPolicy < ApplicationPolicy
    def show?
      user.corpora.include?(record)
    end
    alias_method :edit?, :show?
    alias_method :destroy?, :show?

    class Scope < Scope
      def resolve
        scope.where(editor: user)
      end
    end
  end
end
