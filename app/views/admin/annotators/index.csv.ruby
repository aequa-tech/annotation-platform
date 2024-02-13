require "csv"

CSV.generate do |csv|
  # set title row
  csv << [
    Admin::Annotator.human_attribute_name(:id),
    Admin::Annotator.human_attribute_name(:fullname),
    Admin::Annotator.human_attribute_name(:created_at),
    Admin::Annotator.human_attribute_name(:updated_at),
    Admin::Annotator.human_attribute_name(:editor_id),
    Admin::Annotator.human_attribute_name(:email)
  ]
  # set body rows
  @annotators.each do |annotator|
    csv << [
      annotator.id,
      annotator.fullname,
      annotator.created_at,
      annotator.updated_at,
      annotator.editor_id,
      annotator.email
    ]
  end
end
