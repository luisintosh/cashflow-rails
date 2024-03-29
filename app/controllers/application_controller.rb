class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :error
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  layout :select_layout

  private
  def select_layout
    user_signed_in? ? 'application' : 'application_guess'
  end
end
