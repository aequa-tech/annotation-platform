module Management
  class BaseController < ActionController::Base
    class Forbidden < ActionController::ActionControllerError; end
    include ::Admin::ErrorHandlers

    layout "management"

    before_action :turbo_frame_request_variant
    before_action :authenticate_editor!

    private

    def turbo_frame_request_variant
      request.variant = :turbo_frame if turbo_frame_request?
    end
  end
end
