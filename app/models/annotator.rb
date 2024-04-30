class Annotator < ApplicationRecord
  class << self
    attr_accessor :annotators_csv
  end

  devise :invitable, :database_authenticatable,
    :recoverable, :rememberable, :validatable

  belongs_to :editor
  has_many :annotations, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end

# == Schema Information
#
# Table name: annotators
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
#  editor_id              :bigint           not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_annotators_on_editor_id         (editor_id)
#  index_annotators_on_email             (email) UNIQUE
#  index_annotators_on_invitation_token  (invitation_token) UNIQUE
#  index_annotators_on_invited_by        (invited_by_type,invited_by_id)
#  index_annotators_on_invited_by_id     (invited_by_id)
#
# Foreign Keys
#
#  fk_rails_...  (editor_id => editors.id)
#
