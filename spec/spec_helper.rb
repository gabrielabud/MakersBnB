ENV['RACK_ENV'] ||= 'test'

require './app/app'
require 'capybara'
require 'capybara/poltergeist'
require 'capybara/rspec'
require 'database_cleaner'
require './spec/features/web_helpers'

Capybara.app = App
Capybara.default_driver = :poltergeist

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:each) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

end
