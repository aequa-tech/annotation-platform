require "csv"

class ImportCsvJob < ActiveJob::Base
  queue_as :default

  def perform(current_editor_id, blob_key, corpus_id)
    corpus = Corpus.find_by(id: corpus_id)
    return if corpus.nil?

    response = ImportCorpus.call(current_editor_id, blob_key, corpus)
    raise response if [:failure, :partial_success].include? response
  end
end
