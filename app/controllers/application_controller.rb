class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :set_the_database
  
  protected

  def is_authenticated
    redirect_to login_url, alert: "Not authorized" unless session[:user_id]
  end
  
  def set_the_database
    @database = @database || Ashikawa::Core::Database.new do |config|
      config.url = "http://localhost:8529"
    end
  end
  
  def auto_styles
    [
      "sedan",
      "sports car",
      "hatchback",
      "sports utility vehicle",
      "minivan",
      "microcar",
      "station wagon",
      "van",
      "recreational vehicle",
      "limousine",
      "other"
    ]
  end
  
  def auto_statuses
    ['available', 'pending', 'sold']
  end
  
  def credit_app_statuses
    ['new', 'pending', 'approved', 'denied']
  end
  
  def min_price
    1000
  end
  
  def max_price
    100_000
  end
  
  def first_year
    1920
  end
  
  def next_year
    Date.today.year + 1
  end
end
