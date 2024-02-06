require 'csv'

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::Editor.human_attribute_name(:id),
    Admin::Editor.human_attribute_name(:fullname),
    Admin::Editor.human_attribute_name(:created_at),
    Admin::Editor.human_attribute_name(:updated_at),
    Admin::Editor.human_attribute_name(:email),
  ]
  # set body rows
  @editors.each do |editor|
    csv << [
      editor.id,
      editor.fullname,
      editor.created_at,
      editor.updated_at,
      editor.email,
    ]
  end
end