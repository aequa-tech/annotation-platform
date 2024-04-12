FactoryBot.define do
  factory :lines_set do
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
