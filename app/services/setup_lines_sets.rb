class SetupLinesSets < ApplicationService
  attr_reader :current_editor, :text_lines_per_set, :corpus

  def initialize(current_editor_id, text_lines_per_set, corpus)
    @current_editor = Editor.find_by(id: current_editor_id)
    @text_lines_per_set = text_lines_per_set
    @corpus = corpus
  end

  def call
    corpus.lines_sets.insert_all!(lines_sets_attributes)

    counter = 0
    set_index = 0
    while corpus.text_lines.ordered.offset(counter).limit(text_lines_per_set.to_i).any?
      corpus.text_lines
        .ordered
        .offset(counter).limit(text_lines_per_set.to_i)
        .update_all(lines_set_id: corpus.lines_sets[set_index].id)

      counter += text_lines_per_set.to_i
      set_index += 1
    end

    # stream("management/corpora/show_imported_lines_path", { resource: corpus })

    # stream a Turbo stream to the client that will update the UI with the link to the created sets
    Turbo::StreamsChannel.broadcast_replace_to(
      ["import_corpus_channel", current_editor.to_gid_param].join(":"),
      target: "create_lines_sets_task",
      partial: "management/corpora/index_lines_sets_path",
      locals: { resource: corpus }
    )
  end

  private

  # Returns an array of hashes with the title attribute for each set
  # divmod returns an array with the quotient and modulus of the division
  # the number of sets is the quotient plus one if the modulus is not zero
  def lines_sets_attributes
    quotient, modulus = corpus.text_lines.count.divmod(text_lines_per_set.to_i)
    range = modulus.zero? ? (0...quotient) : (0...quotient + 1)

    range.inject([]) do |memo, n|
      memo << { title: "Set ##{n + 1}" }
    end
  end
end
