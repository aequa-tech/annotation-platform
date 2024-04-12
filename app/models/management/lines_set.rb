module Management
  class LinesSet < ::LinesSet
    scope :title_eq, ->(v) do
      where(title: v) if v.present?
    end

    scope :corpus_id_eq, ->(v) do
      where(corpus_id: v) if v.present?
    end
  end
end

# == Schema Information
#
# Table name: lines_sets
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  corpus_id  :bigint           not null
#
# Indexes
#
#  index_lines_sets_on_corpus_id            (corpus_id)
#  index_lines_sets_on_corpus_id_and_title  (corpus_id,title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (corpus_id => corpora.id)
#
