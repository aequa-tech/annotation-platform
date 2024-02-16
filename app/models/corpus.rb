# frozen_string_literal: true

class Corpus < ApplicationRecord
  validates :title, presence: true
  belongs_to :editor

  has_one_attached :input_file
end
