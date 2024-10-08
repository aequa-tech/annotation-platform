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

    scope :email_full_like, ->(v) do
      where(arel_table[:email].matches("%#{v}%")) if v.present?
    end
  end
end

# == Schema Information
#
# Table name: editors
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fullname               :string
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_editors_on_email             (email) UNIQUE
#  index_editors_on_invitation_token  (invitation_token) UNIQUE
#  index_editors_on_invited_by        (invited_by_type,invited_by_id)
#  index_editors_on_invited_by_id     (invited_by_id)
#
