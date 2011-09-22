Tolk::ApplicationController.authenticator = proc {
  authenticate_or_request_with_http_basic do |user_name, password|
    user_name == 'admin' && password == 'cacacaca'
  end
}
require 'tolk'
require 'tolk/sync'
require 'tolk/import'