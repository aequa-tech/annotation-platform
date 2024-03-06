class AssignTextLinesToSetsJob < ActiveJob::Base
  queue_as :default

  def perform(corpus_id, text_lines_count)
    corpus = Corpus.find(corpus_id)
    corpus.text_lines.each_slice(sets_count) do |lines|
      corpus.lines_sets.create!(text_lines: lines)
    end
  end
end
