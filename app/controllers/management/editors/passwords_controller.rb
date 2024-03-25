# frozen_string_literal: true

module Management
  class Editors::PasswordsController < Devise::PasswordsController
    layout "management"
  end
end
