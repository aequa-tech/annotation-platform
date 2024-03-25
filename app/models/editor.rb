class Editor < ApplicationRecord
  devise :database_authenticatable,
    :recoverable, :rememberable, :validatable

  has_many :corpora, dependent: :destroy
end
