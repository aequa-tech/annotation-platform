module Management
  class Taxonomy < ::Taxonomy
    scope :id_eq, ->(v) do
      where(id: v) if v.present?
    end

    scope :title_full_like, ->(v) do
      where(arel_table[:title].matches("%#{v}%")) if v.present?
    end

    scope :editor_id_eq, ->(v) do
      where(editor_id: v) if v.present?
    end
  end
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
