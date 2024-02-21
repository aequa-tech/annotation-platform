module Management
  class Corpus < ::Corpus
    attr_accessor :remove_input_file
    before_validation { self.input_file = nil if remove_input_file.to_s == "1" }

    scope :id_eq, ->(v) do
      where(id: v) if v.present?
    end
  end
end
