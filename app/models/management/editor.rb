module Management
  class Editor < ::Editor
    validates :email, presence: true
    validates :password, presence: true

    scope :email_eq, ->(v) do
      where(email: v) if v.present?
    end
  end
end
