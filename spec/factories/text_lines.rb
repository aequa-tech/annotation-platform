FactoryBot.define do
  factory :text_line do
    content { "MyText" }
    corpus
  end
end

# == Schema Information
#
# Table name: text_lines
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  position     :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  corpus_id    :bigint           not null
#  external_id  :string
#  lines_set_id :bigint
#
# Indexes
#
#  index_text_lines_on_corpus_id     (corpus_id)
#  index_text_lines_on_lines_set_id  (lines_set_id)
#
# Foreign Keys
#
#  fk_rails_...  (corpus_id => corpora.id)
#  fk_rails_...  (lines_set_id => lines_sets.id)
#
