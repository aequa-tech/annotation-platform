# frozen_string_literal: true

module Admin
  class AdminUsers::PasswordsController < Devise::PasswordsController
    layout "admin"
  end
end
