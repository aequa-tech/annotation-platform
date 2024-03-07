class TextLine < ApplicationRecord
  belongs_to :corpus
  belongs_to :lines_set, optional: true

  validates :content, presence: true

  scope :ordered, -> { order(:position) }
end
