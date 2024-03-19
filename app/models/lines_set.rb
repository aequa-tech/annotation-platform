class LinesSet < ApplicationRecord
  attr_accessor :task_annotator_ids

  belongs_to :corpus
  has_many :text_lines, dependent: :nullify
  has_many :tasks, dependent: :destroy
  has_many :annotators, through: :tasks

  validates :corpus_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :corpus_id }
end
