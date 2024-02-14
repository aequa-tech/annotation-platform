module Management
  class Annotator < ::Annotator
    belongs_to :editor, foreign_key: "editor_id"

    delegate :fullname, to: :editor, prefix: true, allow_nil: true

    validates :fullname, presence: true
    validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :editor_id, presence: true

    scope :id_eq, ->(v) do
      where(id: v) if v.present?
    end

    scope :fullname_full_like, ->(v) do
      where(arel_table[:fullname].matches("%#{v}%")) if v.present?
    end

    scope :email_full_like, ->(v) do
      where(arel_table[:email].matches("%#{v}%")) if v.present?
    end

    scope :editor_id_eq, ->(v) do
      where(editor_id: v) if v.present?
    end
  end
end
