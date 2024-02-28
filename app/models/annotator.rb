class Annotator < ApplicationRecord
  devise :database_authenticatable,
    :recoverable, :rememberable, :validatable

  belongs_to :editor

  validates :email, presence: true, uniqueness: true
end
