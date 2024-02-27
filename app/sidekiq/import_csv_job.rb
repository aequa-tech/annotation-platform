require "csv"

class ImportCsvJob < ActiveJob::Base
  queue_as :default

  def perform(blob_key, corpus_id)
    csv_url = ActiveStorage::Blob.service.send(:path_for, blob_key)

    CSV.foreach(csv_url, headers: true).each.with_index(1) do |row, row_index|
      row_index += 1
      SaveTextLineJob.perform_later(corpus_id, { content: row["content"], external_id: row["external_id"], position: row_index })
    end
  end
end
