# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Emuzikos::Application.initialize!

# HAML OPTIONS
Haml::Template.options[:format] = :html5

I18n.backend.store_translations :en, :messages_count => {
  :one => 'you have 1 unread message',
  :other => 'You have %{count} unread messages'
}

# Set default locale for country_select
Carmen.default_locale = :en

#Encoding.default_internal = 'UTF-8'