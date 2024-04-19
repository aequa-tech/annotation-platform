json.tasks do
  json.array! @corpus.tasks, partial: "management/tasks/show", as: :task
end
