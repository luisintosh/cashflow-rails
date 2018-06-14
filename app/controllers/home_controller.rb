class HomeController < ApplicationController
  skip_load_and_authorize_resource
  skip_before_action :authenticate_user!, :only => [:index]

  def index
  end
end
