class ApplicationController < ActionController::Base
  class Forbidden < ActionController::ActionControllerError; end
  include ::Admin::ErrorHandlers
  include Pundit::Authorization

  protect_from_forgery with: :exception
  before_action :authenticate_annotator!

  def pundit_user
    current_annotator
  end
end
