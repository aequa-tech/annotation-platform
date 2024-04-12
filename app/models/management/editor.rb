module Management
  class Editor < ::Editor
    validates :email, presence: true
    validates :password, presence: true

    scope :email_eq, ->(v) do
      where(email: v) if v.present?
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
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_editors_on_email  (email) UNIQUE
#
