class ImportCorpus < ApplicationService
  attr_reader :blob_key, :corpus

  def initialize(blob_key, corpus)
    @blob_key = blob_key
    @corpus = corpus
  end

  def call
    ActiveStorage::Blob.find_by(key: blob_key).open do |temp_file|
      CSV.foreach(temp_file, headers: true).each.with_index(1) do |row, row_index|
        next if row["content"].blank?
        next if row["external_id"].present? && corpus.text_lines.exists?(external_id: row["external_id"])

        corpus.text_lines.create!(content: row["content"], external_id: row["external_id"], position: row_index)
      end
    end
  end
end
