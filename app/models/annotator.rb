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
