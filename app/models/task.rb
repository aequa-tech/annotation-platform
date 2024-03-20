class Task < ApplicationRecord
  belongs_to :lines_set
  has_one :corpus, through: :lines_set
  belongs_to :annotator
  has_many :annotations, dependent: :destroy
  has_many :text_lines, through: :lines_set

  validates :lines_set_id, presence: true
  validates :annotator_id, presence: true
  validates :annotator_id, uniqueness: { scope: :lines_set_id }

  def title
    [lines_set.title, corpus.title].join(" - ")
  end
end
