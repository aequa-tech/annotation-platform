module Management
  class LinesSet < ::LinesSet
    scope :title_eq, ->(v) do
      where(title: v) if v.present?
    end
  end
end
