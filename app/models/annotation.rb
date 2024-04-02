class Annotation < ApplicationRecord
  belongs_to :text_line
  belongs_to :annotator
  belongs_to :task

  validates :text_line, :annotator, :content, :task, presence: true
end
