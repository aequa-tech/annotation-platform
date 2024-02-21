class TextLine < ApplicationRecord
  belongs_to :corpus

  validates :content, presence: true
end
