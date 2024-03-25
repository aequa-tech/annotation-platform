class Editor < ApplicationRecord
  devise :database_authenticatable,
    :recoverable, :rememberable, :validatable
end
