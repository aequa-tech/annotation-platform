class HomeController < ApplicationController
  layout "application"

  def index
    @external_form_url = "https://www.aequa-tech.com/landing/annotation-platform"
  end
end
