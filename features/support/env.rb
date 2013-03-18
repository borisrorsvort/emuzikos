ENV["RAILS_ENV"] ||= "test"

require 'spinach-rails'
require './config/environment'
require 'capybara/poltergeist'
require 'factory_girl'
require 'database_cleaner'
require 'rspec'
Capybara.default_selector = :css
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {
    timeout: 100,
    inspector: true
  })
end

Capybara.javascript_driver = :selenium
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Spinach.hooks.before_scenario do
  DatabaseCleaner.start
end

Spinach.hooks.after_scenario do
  DatabaseCleaner.clean
end


Spinach.hooks.on_tag('selenium') do |scenario|
  puts 'using selenium'
  Capybara.default_driver = :selenium
  Capybara.javascript_driver = :selenium
end

class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end

# Forces all threads to share the same connection. This works on
# Capybara because it starts the web server in a thread.
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection



