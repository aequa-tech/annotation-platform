class Annotator < ApplicationRecord
  devise :database_authenticatable,
    :recoverable, :rememberable, :validatable

  belongs_to :editor
  has_many :annotations, dependent: :destroy
  has_many :tasks, dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
