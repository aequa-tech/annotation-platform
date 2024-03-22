module Management
  class Corpus < ::Corpus
    attr_accessor :remove_input_file, :lines_sets_count
    before_validation { self.input_file = nil if remove_input_file.to_s == "1" }

    scope :id_eq, ->(v) do
      where(id: v) if v.present?
    end

    scope :title_full_like, ->(v) do
      where(arel_table[:title].matches("%#{v}%")) if v.present?
    end

    scope :editor_id_eq, ->(v) do
      where(editor_id: v) if v.present?
    end
  end
end
