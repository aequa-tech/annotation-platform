module Management
  class TextLine < ::TextLine
    scope :external_id_eq, ->(v) do
      where(external_id: v) if v.present?
    end
  end
end
