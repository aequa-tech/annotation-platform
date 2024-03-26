module Api
  class ApplicationController < ActionController::API
    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def pundit_user
      current_annotator
    end

    private

    def user_not_authorized
      flash_message = I18n.t("pundit.not_authorized_error")

      respond_to do |format|
        format.json do
          render json: { error: flash_message }, status: :forbidden
        end
      end
    end
  end
end
