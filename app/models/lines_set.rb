class LinesSet < ApplicationRecord
  belongs_to :corpus
  has_many :text_lines, dependent: :destroy

  validates :corpus_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :corpus_id }
end
