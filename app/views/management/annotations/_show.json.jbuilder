json.array! annotation.content["body"] do |body|
  json.id annotation.id
  json.annotator_id annotation.annotator_id
  json.text_line_id annotation.text_line_id
  json.created_at annotation.created_at
  json.updated_at annotation.updated_at
  json.value do
    json.text body["value"]
    json.purpose body["purpose"]
    json.interval do
      json.start_at annotation.content["target"]["selector"][1]["start"]
      json.end_at annotation.content["target"]["selector"][1]["end"]
      json.exact_highlight annotation.content["target"]["selector"][0]["exact"]
    end
  end
end
