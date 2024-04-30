# frozen_string_literal: true

module Management
  class Editors::InvitationsController < Devise::InvitationsController
    layout "management"

    def after_accept_path_for(resource)
      management_root_path
    end
  end
end
