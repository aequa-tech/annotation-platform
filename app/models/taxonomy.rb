class Taxonomy < ApplicationRecord
  belongs_to :editor
  has_and_belongs_to_many :corpora

  validates :title, :editor_id, presence: true
  validates :title, uniqueness: { scope: :editor_id }
end
