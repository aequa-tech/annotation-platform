module Annotators
  class BaseController < ActionController::Base
    class Forbidden < ActionController::ActionControllerError; end
    include ::Admin::ErrorHandlers
    include Pundit::Authorization

    layout "application"

    before_action :turbo_frame_request_variant
    before_action :authenticate_annotator!

    def pundit_user
      current_annotator
    end

    private

    def turbo_frame_request_variant
      request.variant = :turbo_frame if turbo_frame_request?
    end
  end
end
