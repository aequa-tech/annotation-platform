# frozen_string_literal: true

module Management
  class CorpusPolicy < ApplicationPolicy
    def show?
      user.corpora.include?(record)
    end

    def edit_lines_sets_count?
      show? && record.lines_sets.empty?
    end
  end
end
