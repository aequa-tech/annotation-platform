class Editor < ApplicationRecord
  devise :database_authenticatable,
    :recoverable, :rememberable, :validatable

  has_many :corpora, dependent: :destroy
  has_many :annotators, dependent: :destroy
  has_many :taxonomies, dependent: :destroy
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
