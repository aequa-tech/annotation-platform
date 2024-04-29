# frozen_string_literal: true

module Annotators
  class PasswordsController < Devise::PasswordsController
    layout "application"

    def after_resetting_password_path_for(resource)
      annotators_assigned_path
    end
  end
end
