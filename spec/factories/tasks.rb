FactoryBot.define do
  factory :task do
    annotator
    lines_set
  end
end

# == Schema Information
#
# Table name: tasks
#
#  id           :bigint           not null, primary key
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
