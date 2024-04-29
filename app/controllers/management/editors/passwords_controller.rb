# frozen_string_literal: true

module Management
  class Editors::PasswordsController < Devise::PasswordsController
    layout "management"

    def after_resetting_password_path_for(resource)
      management_root_path
    end
  end
end
