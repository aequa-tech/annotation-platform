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

# == Schema Information
#
# Table name: annotators
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fullname               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  editor_id              :bigint           not null
#
# Indexes
#
#  index_annotators_on_editor_id  (editor_id)
#  index_annotators_on_email      (email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (editor_id => editors.id)
#
