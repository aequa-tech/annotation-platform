module Api
  class ApplicationController < ActionController::API
    # before_action :authenticate_user!

    # def authenticate_user!
    #   head :unauthorized unless current_user
    # end

    # def current_user
    #   @current_user ||= User.find_by(authentication_token: params[:authentication_token])
    # end
  end
end
