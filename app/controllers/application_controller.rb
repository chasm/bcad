class ApplicationController < ActionController::Base
  # protect_from_forgery
  before_filter :set_the_database
  
  protected
  
  def set_the_database
    @database = @database || Ashikawa::Core::Database.new do |config|
      config.url = "http://localhost:8529"
    end
  end
end
