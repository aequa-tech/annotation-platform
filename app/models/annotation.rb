class Annotation < ApplicationRecord
  belongs_to :text_line
  belongs_to :annotator
  belongs_to :task

  validates :text_line, :annotator, :content, :task, presence: true

  scope :by_task, ->(task) { where(task_id: task.id) if task.present? }
end

# == Schema Information
#
# Table name: annotations
#
#  id           :bigint           not null, primary key
#  content      :jsonb
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  annotator_id :bigint           not null
#  task_id      :bigint
#  text_line_id :bigint           not null
#
# Indexes
#
#  index_annotations_on_annotator_id  (annotator_id)
#  index_annotations_on_task_id       (task_id)
#  index_annotations_on_text_line_id  (text_line_id)
#
# Foreign Keys
#
#  fk_rails_...  (annotator_id => annotators.id)
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (text_line_id => text_lines.id)
#
