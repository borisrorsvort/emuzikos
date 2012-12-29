Emuzikos::Application.configure do

  config.assets.compress                      = true
  config.assets.digest                        = true
  config.cache_classes                        = true
  config.consider_all_requests_local          = false
  config.action_controller.perform_caching    = true

  config.active_support.deprecation           = :notify

  config.action_mailer.default_url_options    = { :host => 'emuzikos.com' }

  config.action_mailer.raise_delivery_errors  = false
  config.action_mailer.perform_deliveries     = true
  config.action_mailer.delivery_method        = :smtp
  config.action_mailer.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => 'emuzikos.com',
    :user_name            => 'noreply@emuzikos.com',
    :password             => '3muz1k0sn0r3ply2',
    :authentication       => 'plain',
    :enable_starttls_auto => true  }

  config.serve_static_assets                  = true
  config.i18n.fallbacks                       = true
  config.active_support.deprecation           = :notify
  ENV["REDISTOGO_URL"] = 'redis://redistogo:783ce13beaeac541f0caad5893fe4031@cowfish.redistogo.com:9416/'
end
