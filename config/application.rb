require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)  
  Bundler.require *Rails.groups(:assets => %w(development test))
end  

module Emuzikos
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**/*', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en

    config.encoding = "utf-8"

    config.filter_parameters += [:password,  :password_confirmation]

    config.assets.enabled = true
    config.assets.precompile += %w[active_admin.css active_admin.js homepage.css]

    #config.assets.precompile << /(^[^_]|\/[^_])[^\/]*/

    #Set the Devise layout to home except user_registration_edit
    config.to_prepare do
      Devise::SessionsController.layout "home"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "home" }
      Devise::ConfirmationsController.layout "home"
      Devise::UnlocksController.layout "home"
      Devise::PasswordsController.layout "home"
    end
    if Rails.env.production?
      config.middleware.insert_before Rack::Lock, Rack::NoWWW
    end

    config.after_initialize do |app|
      app.routes.append{ match '*path', :to => 'errors#404', :constraints => lambda{|request| !request.path.starts_with?("/auth") }} unless config.consider_all_requests_local
    end

  end
end
