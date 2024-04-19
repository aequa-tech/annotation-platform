module Management
  class Corpus < ::Corpus
    attr_accessor :remove_input_file, :lines_sets_count
    before_validation { self.input_file = nil if remove_input_file.to_s == "1" }

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
# Table name: corpora
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  editor_id  :bigint           not null
#
# Indexes
#
#  index_corpora_on_editor_id  (editor_id)
#
# Foreign Keys
#
#  fk_rails_...  (editor_id => editors.id)
#
