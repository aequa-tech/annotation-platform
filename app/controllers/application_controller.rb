class ApplicationController < ActionController::Base
  class Forbidden < ActionController::ActionControllerError; end
  include ::Admin::ErrorHandlers

  protect_from_forgery with: :exception
  before_action :authenticate_annotator!
end
