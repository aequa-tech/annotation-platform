class LinesSet < ApplicationRecord
  attr_accessor :task_annotator_ids

  belongs_to :corpus
  has_many :text_lines, dependent: :nullify
  has_many :tasks, dependent: :destroy
  has_many :annotators, through: :tasks

  accepts_nested_attributes_for :tasks, allow_destroy: true

  validates :corpus_id, presence: true
  validates :title, presence: true
  validates :title, uniqueness: { scope: :corpus_id }
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
