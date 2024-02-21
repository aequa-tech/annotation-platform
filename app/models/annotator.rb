class Annotator < ApplicationRecord
  belongs_to :editor

  validates :email, presence: true, uniqueness: true
end
