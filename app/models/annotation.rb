class Annotation < ApplicationRecord
  belongs_to :text_line
  belongs_to :annotator

  validates :text_line, :annotator, :content, presence: true

  scope :by_task, ->(task) { where(task_id: task.id) }
end
