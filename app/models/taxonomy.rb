class Taxonomy < ApplicationRecord
  belongs_to :editor
  has_and_belongs_to_many :corpora

  validates :title, :editor_id, presence: true
  validates :title, uniqueness: { scope: :editor_id }
end

# == Schema Information
#
# Table name: taxonomies
#
#  id          :bigint           not null, primary key
#  description :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  editor_id   :bigint           not null
#
# Indexes
#
#  index_taxonomies_on_editor_id            (editor_id)
#  index_taxonomies_on_title_and_editor_id  (title,editor_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (editor_id => editors.id)
#
