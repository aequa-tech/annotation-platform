# frozen_string_literal: true

module Annotators
  class SessionsController < Devise::SessionsController
    layout "application"

    def after_sign_in_path_for(resources)
      annotators_assigned_path
    end

    def after_sign_out_path_for(resource)
      new_annotator_session_path
    end
  end
end
