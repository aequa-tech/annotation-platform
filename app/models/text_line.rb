class TextLine < ApplicationRecord
  belongs_to :corpus
  belongs_to :lines_set, optional: true
  has_many :tasks, through: :lines_set
  has_many :annotations, dependent: :destroy

  validates :content, presence: true

  scope :ordered, -> { order(:position) }
end
