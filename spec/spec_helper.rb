ENV["RACK_ENV"] = 'test'
require 'database_cleaner'
require './app/glitter'

require 'capybara/rspec'

Capybara.app = Sinatra::Application



RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus


  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end


  config.order = 'random'
  end
