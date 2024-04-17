class ApplicationController < ActionController::Base
  class Forbidden < ActionController::ActionControllerError; end
  include ::Admin::ErrorHandlers
  include Pundit::Authorization

  protect_from_forgery with: :exception
end
