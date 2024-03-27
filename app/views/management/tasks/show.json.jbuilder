json.task do
  json.extract! @task, :id, :annotator_id, :lines_set_id, :created_at, :updated_at
  json.annotator do
    json.extract! @task.annotator, :id, :fullname, :email
  end
  json.text_lines do
    json.array! @task.text_lines do |text_line|
      json.text_id text_line.id
      json.text_external_id text_line.external_id
      json.data do
        json.text text_line.content
      end
      json.annotations do
        next if text_line.annotations.by_task(@task).empty?

        json.array! text_line.annotations.by_task(@task), partial: "management/annotations/show", as: :annotation
      end
    end
  end
end
