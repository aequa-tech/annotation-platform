class ImportCorpus < ApplicationService
  attr_reader :blob_key, :corpus, :current_editor

  def initialize(current_editor_id, blob_key, corpus)
    @blob_key = blob_key
    @corpus = corpus
    @current_editor = Editor.find_by(id: current_editor_id)
  end

  def call
    ActiveStorage::Blob.find_by(key: blob_key).open do |temp_file|
      total_count = `wc -l #{temp_file.path}`.split.first.to_i

      CSV.foreach(temp_file, headers: true).each.with_index(1) do |row, row_index|
        next if row["content"].blank?
        next if row["external_id"].present? && corpus.text_lines.exists?(external_id: row["external_id"])

        corpus.text_lines.create!(content: row["content"], external_id: row["external_id"], position: row_index)
        progress = (row_index * 100) / total_count

        if progress != 0 && progress % 10 == 0
          stream("management/corpora/import_corpus_progress", { progress: progress })
        end
      end

      stream("management/corpora/show_imported_lines_path", { resource: corpus })
    end
  end

  private

  def stream(partial, locals)
    Turbo::StreamsChannel.broadcast_replace_to(
      ["import_corpus_channel", current_editor.to_gid_param].join(":"),
      target: "import_corpus_task",
      partial: partial,
      locals: locals
    )
  end
end
