class Editor < ApplicationRecord
  devise :database_authenticatable,
    :recoverable, :rememberable, :validatable

  has_many :corpora, dependent: :destroy
  has_many :annotators, dependent: :destroy
  has_many :taxonomies, dependent: :destroy
end
