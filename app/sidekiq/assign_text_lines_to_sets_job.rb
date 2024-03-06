class AssignTextLinesToSetsJob < ActiveJob::Base
  queue_as :default

  def perform(corpus_id, text_lines_count)
    corpus = Corpus.find(corpus_id)
    counter = 0
    set_index = 0
    while corpus.text_lines.ordered.offset(counter).limit(text_lines_count.to_i).any?
      corpus.text_lines
        .ordered
        .offset(counter).limit(text_lines_count.to_i)
        .update_all(lines_set_id: corpus.lines_sets[set_index].id)

      counter += text_lines_count.to_i
      set_index += 1
    end
  end
end
