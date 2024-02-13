module Admin
  class Editor < ::Editor
    validates :fullname, presence: true
    validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

    scope :id_eq, ->(v) do
      where(id: v) if v.present?
    end

    scope :fullname_full_like, ->(v) do
      where(arel_table[:fullname].matches("%#{v}%")) if v.present?
    end
  end
end
