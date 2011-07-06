Emuzikos::Application.configure do
  
  
  
  # Settings specified here will take precedence over those in config/environment.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send  
  config.action_mailer.raise_delivery_errors = false

  config.active_support.deprecation = :notify
  
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_deliveries = true
  ##config.action_mailer.default_url_options = { :host => "emuzikos.com" }
  #onfig.action_mailer.delivery_method = :smtpconfig.action_mailer.default_url_options = { :host => "emuzikos.com" }

  # ActionMailer::Base.smtp_settings = {
  #   :address => "smtp.gmail.com",
  #   :port => 587,
  #   :authentication => :plain,
  #   :user_name => "noreply@emuzikos.com",
  #   :password => '3muz1k0sn0r3ply'
  # }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :user_name            => 'noreply@emuzikos.com',
    :password             => '3muz1k0sn0r3ply2',
    :authentication       => 'plain',
    :enable_starttls_auto => true  }
  


  config.after_initialize do
    Bullet.enable = false
    Bullet.alert = false
    Bullet.bullet_logger = true
    #Bullet.console = true
    Bullet.rails_logger = true
    Bullet.disable_browser_cache = true
    begin
       require 'ruby-growl'
       Bullet.growl = true
     rescue MissingSourceFile, Exception
     end
  end

  config.logger = Logger.new(Rails.root.join("log",Rails.env + ".log"),3,5*1024*1024)
  
  if $0 == "irb"
    config.logger = Logger.new(STDOUT)
  else
    config.logger = Logger.new(Rails.root.join("log",Rails.env + ".log"),3,5*1024*1024)  
  end
  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
end

