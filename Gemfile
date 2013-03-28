source "https://rubygems.org"

# Core Gems

gem 'rails', '3.2.13'
gem 'mysql2'
gem "jquery-rails"
# gem 'redis'

gem "devise"
gem 'omniauth'
gem "omniauth-facebook"
gem "omniauth-soundcloud"
gem "activeadmin", :git => "git://github.com/gregbell/active_admin.git"
gem 'meta_search'

gem "airbrake"
gem "populator"
gem "faker"
gem "squeel"
gem "ransack", :git => "git://github.com/Eric-Guo/ransack.git"
gem "gritter"
gem "haml"
gem "sass"

gem "settingslogic"
gem 'simple_form'
gem 'simple-private-messages', '0.0.0', :git => 'git://github.com/jongilbraith/simple-private-messages.git'
gem "paperclip"
gem 'aws-s3', :require => 'aws/s3'
gem 'aws-sdk'

gem 'country_select'
gem 'httparty'
gem 'carmen'
gem 'carmen-rails'
gem 'songkickr'
gem "soundcloud"
gem "hominid"
gem 'preferences', :git => 'git://github.com/mojotech/preferences.git'
gem 'twitter'
gem 'geocoder'
gem 'rack-no-www'
gem 'pg'
gem 'meta-tags', :require => 'meta_tags'
gem "friendly_id", "~> 4.0.0"
gem 'impressionist'

gem 'wicked'
gem 'annotate'

gem 'bootstrap-sass-rails'
gem "highcharts-rails", "~> 2.3.0"
gem "newrelic_rpm"
gem 'font-awesome-sass-rails'

gem 'turbolinks'
gem 'strong_parameters', git: "git://github.com/rails/strong_parameters.git"
gem 'spinjs-rails'
gem 'mixpanel'

gem 'chosen-rails'
gem 'thin'

group :assets do
  gem 'uglifier'
  gem 'sass-rails'
  gem "compass-rails"
  gem 'susy'
end

group :production do
  gem 'dynamic_errors'
end
group :development, :test do
  gem 'rails-footnotes', '>= 3.7.5.rc4'
  gem "hirb"
  gem "bullet"
  gem "nifty-generators"
  gem 'rails_best_practices'
  gem 'simplecov', :require => false
  gem "letter_opener"
  gem 'heroku-rails'
  gem 'watchr'

  gem "guard-livereload"
  gem "guard-rspec"
  gem 'growl'
  gem "spork"
  gem "guard-spork"

  gem "factory_girl_rails"
  gem 'rspec-rails'
  gem "shoulda"
  gem "database_cleaner"
  gem "capybara"
  gem "selenium-webdriver"
  gem 'poltergeist'
  gem 'spinach-rails'
  # attempt to fix ttf phantomjs issue gem 'rack-contrib'
  gem "launchy"

  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  gem "taps"
  gem 'quiet_assets'
  gem "better_errors"
  gem "binding_of_caller"

  platforms :mri_18 do
    gem "ruby-debug"
  end
  platforms :mri_19 do
    gem 'debugger'
  end
end

group :test do
  gem 'rack-contrib'
  gem 'fuubar'
end

gem 'tap'
