# frozen_string_literal: true

module Management
  class Editors::SessionsController < Devise::SessionsController
    layout "management"

    def after_sign_in_path_for(resources)
      management_root_path
    end

    def after_sign_out_path_for(resource)
      new_editor_session_path
    end
  end
end
