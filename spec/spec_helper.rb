ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/rspec'
# require 'database_cleaner'
# require 'fabrication'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.before(:suite) do
    # @database = @database || Ashikawa::Core::Database.new do |config|
    #   config.url = "http://localhost:8529"
    # end
  end
  # 
  # config.before(:each) do
  #   DatabaseCleaner.start
  # end
  # 
  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end

  # Fabrication.configure do |config|
  #   config.fabricator_path = 'data/fabricators'
  #   config.path_prefix = Rails.root
  #   config.sequence_start = 10000
  # end

  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation
  # config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end
