class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_annotator!

  private

  def authenticate_annotator!
    return if annotator_signed_in?

    redirect_to new_annotator_session_path
  end
end
