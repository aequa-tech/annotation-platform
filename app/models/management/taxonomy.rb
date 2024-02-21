module Management
  class Taxonomy < ::Taxonomy
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
