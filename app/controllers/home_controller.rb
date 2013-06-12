class HomeController < ApplicationController
  before_filter :is_authenticated
  
  def index
    @current_user_id = session[:user_id]
    @auto_statuses = auto_statuses
    @auto_styles = auto_styles
    @credit_app_statuses = credit_app_statuses
    gon.rabl
  end
end
