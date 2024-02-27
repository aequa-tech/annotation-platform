class SaveTextLineJob < ActiveJob::Base
  queue_as :default

  def perform(corpus_id, text_line_attributes)
    corpus = Corpus.find(corpus_id)
    return if corpus.nil?
    return if text_line_attributes[:content].blank?
    return if text_line_attributes[:external_id].present? && corpus.text_lines.exists?(external_id: text_line_attributes[:external_id])
    return if corpus.text_lines.exists?(position: text_line_attributes[:position])

    corpus.text_lines.create!(text_line_attributes)
  end
end
