class Taxonomy < ApplicationRecord
  belongs_to :editor

  validates :title, :editor_id, presence: true
  validates :title, uniqueness: { scope: :editor_id }
end
