require "csv"

class ImportCsvJob < ActiveJob::Base
  queue_as :default

  def perform(blob_key, corpus_id)
    corpus = Corpus.find_by(id: corpus_id)
    return if corpus.nil?

    ImportCorpus.call(blob_key, corpus)
  end
end
