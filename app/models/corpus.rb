# frozen_string_literal: true

class Corpus < ApplicationRecord
  validates :title, presence: true
  belongs_to :editor
  has_and_belongs_to_many :taxonomies
  has_many :lines_sets, dependent: :destroy
  has_many :text_lines, dependent: :destroy

  has_one_attached :input_file
end
