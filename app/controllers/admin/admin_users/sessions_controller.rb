# frozen_string_literal: true

module Admin
  class AdminUsers::SessionsController < Devise::SessionsController
    layout "admin"

    def after_sign_in_path_for(resources)
      admin_root_path
    end

    def after_sign_out_path_for(resource)
      new_admin_user_session_path
    end
  end
end
