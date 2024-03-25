module Management
  class BaseController < ActionController::Base
    class Forbidden < ActionController::ActionControllerError; end
    include ::Admin::ErrorHandlers
    include Pundit::Authorization

    layout "management"

    before_action :turbo_frame_request_variant
    before_action :authenticate_editor!

    def pundit_user
      current_editor
    end

    private

    def turbo_frame_request_variant
      request.variant = :turbo_frame if turbo_frame_request?
    end
  end
end
