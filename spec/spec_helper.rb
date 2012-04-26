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
  require 'simple-private-messages/matchers'
  require 'factory_girl'
    # For Devise
  require "rails/application"
  Spork.trap_method(Rails::Application, :reload_routes!)
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  #FactoryGirl.find_definitions

  Rails.backtrace_cleaner.remove_silencers!

  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation

  RSpec.configure do |config|
    config.include Professionalnerd::SimplePrivateMessages::Shoulda::Matchers
    config.mock_with :rspec

    config.before(:suite) do
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.clean
    end

    config.include Devise::TestHelpers, :type => :controller
  end

  Capybara.javascript_driver = :webkit
end

def each_run
  if spork?
    ActiveSupport::Dependencies.clear
    FactoryGirl.reload
  end

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
end

# If spork is available in the Gemfile it'll be used but we don't force it.
unless (begin; require 'spork'; rescue LoadError; nil end).nil?
  Spork.prefork do
    # Loading more in this block will cause your tests to run faster. However,
    # if you change any configuration or code from libraries loaded here, you'll
    # need to restart spork for it take effect.
    setup_environment
  end

  Spork.each_run do
    # This code will be run each time you run your specs.
    each_run
  end
else
  setup_environment
  each_run
end
# require 'spork'
# #uncomment the following line to use spork with the debugger
# #require 'spork/ext/ruby-debug'

# Spork.prefork do
#   # Loading more in this block will cause your tests to run faster. However,
#   # if you change any configuration or code from libraries loaded here, you'll
#   # need to restart spork for it take effect.
#   require 'simplecov'
#   SimpleCov.start 'rails'

#   ENV["RAILS_ENV"] ||= 'test'
#   require File.expand_path("../../config/environment", __FILE__)
#   require 'rspec/rails'
#   require 'capybara/rspec'
#   require 'capybara/rails'
#   require 'simple-private-messages/matchers'
#   require 'database_cleaner'
#   DatabaseCleaner.strategy = :truncation
#   # Requires supporting ruby files with custom matchers and macros, etc,
#   # in spec/support/ and its subdirectories.
#   Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

#   RSpec.configure do |config|

#     config.mock_with :rspec
#     config.use_transactional_fixtures = true

#     config.treat_symbols_as_metadata_keys_with_true_values = true
#     config.filter_run :focus => true
#     config.run_all_when_everything_filtered = true
#     config.include Professionalnerd::SimplePrivateMessages::Shoulda::Matchers
#       # For Devise
#     require "rails/application"
#     Spork.trap_method(Rails::Application, :reload_routes!)
#     Spork.trap_method(Rails::Application::RoutesReloader, :reload!)


#     def do_login(options = {})
#       @user = Factory(:user, options)
#       visit(new_user_session_path)
#       within("#user_new")  do
#         fill_in 'user_email', :with => @user.email
#         fill_in 'user_password', :with => @user.password
#       end
#       click_button 'Log in'
#       current_path.should match edit_user_path(@user)
#       page.should have_content('Log out')
#     end

#     # if we're already logged in, don't bother doing it again
#     def do_login_if_not_already(options = {})
#       do_login(options) unless @user.present?
#     end
#   end
# end

# Spork.each_run do
#   # This code will be run each time you run your specs.
#   # load "#{Rails.root}/config/routes.rb" 
#   FactoryGirl.reload
#   DatabaseCleaner.clean
#   I18n.backend.reload!

# end

# # --- Instructions ---
# # Sort the contents of this file into a Spork.prefork and a Spork.each_run
# # block.
# #
# # The Spork.prefork block is run only once when the spork server is started.
# # You typically want to place most of your (slow) initializer code in here, in
# # particular, require'ing any 3rd-party gems that you don't normally modify
# # during development.
# #
# # The Spork.each_run block is run each time you run your specs.  In case you
# # need to load files that tend to change during development, require them here.
# # With Rails, your application modules are loaded automatically, so sometimes
# # this block can remain empty.
# #
# # Note: You can modify files loaded *from* the Spork.each_run block without
# # restarting the spork server.  However, this file itself will not be reloaded,
# # so if you change any of the code inside the each_run block, you still need to
# # restart the server.  In general, if you have non-trivial code in this file,
# # it's advisable to move it into a separate file so you can easily edit it
# # without restarting spork.  (For example, with RSpec, you could move
# # non-trivial code into a file spec/support/my_helper.rb, making sure that the
# # spec/support/* files are require'd from inside the each_run block.)
# #
# # Any code that is left outside the two blocks will be run during preforking
# # *and* during each_run -- that's probably not what you want.
# #
# # These instructions should self-destruct in 10 seconds.  If they don't, feel
# # free to delete them.




# # This file is copied to spec/ when you run 'rails generate rspec:install'

