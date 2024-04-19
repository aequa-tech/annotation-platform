# frozen_string_literal: true

class Corpus < ApplicationRecord
  validates :title, presence: true
  belongs_to :editor
  has_and_belongs_to_many :taxonomies
  has_many :lines_sets, dependent: :destroy
  has_many :text_lines, dependent: :destroy
  has_many :tasks, through: :lines_sets

  has_one_attached :input_file
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
