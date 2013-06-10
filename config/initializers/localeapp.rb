require 'localeapp/rails'

Localeapp.configure do |config|
  config.api_key = 'MsH5BPZGkZH8TMGzPfPw9VysKQRJ51J4GD3GHCLFwKXECjRv0E'
  config.poll_interval = 300 if Rails.env.staging?
  config.sending_environments = [:production, :staging]
  config.polling_environments = [:development, :staging]
  config.reloading_environments = [:development, :staging]
end

if Rails.env.staging?
  Localeapp::CLI::Pull.new.execute
end
