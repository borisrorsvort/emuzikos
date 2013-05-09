require File.expand_path('../boot', __FILE__)
require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Emuzikos
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join('my', 'config', 'locales', '**/*', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :fr]
    config.assets.initialize_on_precompile = false

    config.encoding = "utf-8"

    config.filter_parameters += [:password,  :password_confirmation]

    config.assets.enabled = true

    config.assets.precompile += %w( active_admin.css active_admin.js active_admin/print.css highcharts.js )

    #config.assets.precompile << /(^[^_]|\/[^_])[^\/]*/
    config.autoload_paths << "#{config.root}/lib"
    #Set the Devise layout to home except user_registration_edit
    # config.to_prepare do
    #   Devise::SessionsController.layout "home"
    #   Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "application" : "home" }
    #   Devise::ConfirmationsController.layout "home"
    #   Devise::UnlocksController.layout "home"
    #   Devise::PasswordsController.layout "home"
    # end
    if Rails.env.production?
      config.middleware.insert_before Rack::Lock, Rack::NoWWW
    end
    # config.active_record.whitelist_attributes = false
  end
end

module AbstractController
  module Rendering
    module Antifreeze
      def inspect
        @view_renderer.lookup_context.find_all(@_request[:action], @_request[:controller]).inspect
      end
    end
    def view_context
      context = view_context_class.new(view_renderer, view_assigns, self)
      context.extend Antifreeze
      return context
    end
  end
end
