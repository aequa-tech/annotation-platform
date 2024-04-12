class Task < ApplicationRecord
  belongs_to :lines_set
  has_one :corpus, through: :lines_set
  belongs_to :annotator
  has_many :annotations, dependent: :destroy
  has_many :text_lines, through: :lines_set

  validates :lines_set_id, presence: true
  validates :annotator_id, presence: true
  validates :annotator_id, uniqueness: { scope: :lines_set_id }

  scope :completed, -> { where(completed: true) }
  scope :incompleted, -> { where(completed: false) }

  def complete!
    update(completed: true)
  end

  def completed?
    completed
  end

  def incomplete?
    !completed
  end

  def title
    [lines_set.title, corpus.title].join(" - ")
  end
end

# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
#  completed    :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  annotator_id :bigint           not null
#  lines_set_id :bigint           not null
#
# Indexes
#
#  index_tasks_on_annotator_id                   (annotator_id)
#  index_tasks_on_annotator_id_and_lines_set_id  (annotator_id,lines_set_id) UNIQUE
#  index_tasks_on_lines_set_id                   (lines_set_id)
#
# Foreign Keys
#
#  fk_rails_...  (annotator_id => annotators.id)
#  fk_rails_...  (lines_set_id => lines_sets.id)
#
