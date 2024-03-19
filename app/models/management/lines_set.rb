module Management
  class LinesSet < ::LinesSet
    scope :title_eq, ->(v) do
      where(title: v) if v.present?
    end

    scope :corpus_id_eq, ->(v) do
      where(corpus_id: v) if v.present?
    end
  end
end
