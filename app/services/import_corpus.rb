class ImportCorpus < ApplicationService
  attr_reader :blob, :corpus, :current_editor

  def initialize(current_editor_id, blob_key, corpus)
    @corpus = corpus
    @current_editor = Editor.find_by(id: current_editor_id)
    @blob = ActiveStorage::Blob.find_by(key: blob_key)
  end

  def call
    return :failure if blob.blank? || corpus.blank? || current_editor.blank?

    blob.open do |temp_file|
      total_count = File.foreach(temp_file.path).count
      return :partial_success if total_count.zero?

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

    :success
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
