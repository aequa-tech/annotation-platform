# frozen_string_literal: true

module Annotators
  class InvitationsController < Devise::InvitationsController
    layout "application"

    def after_accept_path_for(resource)
      annotators_assigned_path
    end
  end
end
