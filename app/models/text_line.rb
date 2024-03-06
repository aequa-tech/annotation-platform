class TextLine < ApplicationRecord
  belongs_to :corpus
  belongs_to :lines_set

  validates :content, presence: true
end
