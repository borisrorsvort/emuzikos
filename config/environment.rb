# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Emuzikos::Application.initialize!

# HAML OPTIONS
Haml::Template.options[:format] = :html5