# frozen_string_literal: true

module Admin
  class AdminUsers::PasswordsController < Devise::PasswordsController
    layout "admin"

    def after_resetting_password_path_for(resource)
      admin_root_path
    end
  end
end
