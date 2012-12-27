require 'rubygems'


def start_simplecov
  require 'simplecov'
  SimpleCov.start 'rails' unless ENV["SKIP_COV"]
end

def spork?
  defined?(Spork) && Spork.using_spork?
end

def setup_environment
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'

  start_simplecov unless spork?

  if spork?
    ENV['DRB'] = 'true'
    Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  end

  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'
  require 'capybara/rspec'
  # require 'capybara/poltergeist'
  # require 'shoulda/matchers/integrations/rspec'
  require 'simple-private-messages/matchers'
  require 'factory_girl'
  require 'database_cleaner'
  require "rails/application"

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  include Warden::Test::Helpers
  Warden.test_mode!

  Rails.backtrace_cleaner.remove_silencers!
  # Capybara.javascript_driver = :poltergeist
  # Capybara.javascript_driver = :selenium

  # For Devise
  Spork.trap_method(Rails::Application, :reload_routes!)
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  DatabaseCleaner.strategy = :truncation
  RSpec.configure do |config|
    config.mock_with :rspec
    # config.use_transactional_fixtures = true
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    config.include Professionalnerd::SimplePrivateMessages::Shoulda::Matchers
    config.include FactoryGirl::Syntax::Methods

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

    config.include Devise::TestHelpers, :type => :controller
    config.extend ControllerMacros, :type => :controller
  end

end

def each_run
  if spork?
    require 'factory_girl_rails'
    ActiveSupport::Dependencies.clear
    FactoryGirl.reload
  end
  Warden.test_reset!
end

# If spork is available in the Gemfile it'll be used but we don't force it.
unless (begin; require 'spork'; rescue LoadError; nil end).nil?
  Spork.prefork do
    setup_environment
  end

  Spork.each_run do
    each_run
  end
else
  setup_environment
  each_run
end
