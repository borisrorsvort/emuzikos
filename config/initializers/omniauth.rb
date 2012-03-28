Rails.application.config.middleware.use OmniAuth::Builder do

  require 'openid/store/filesystem'



  provider :twitter, '76zeThKPzGSMABaPJRxfA', 'CLPWwv4ZUGe2hVth09JAzkvqi8veVbslb7bH3CavBY'
  #provider :facebook, '226327037396547', '8367d544c64b1c3c3b55ff807c74fabb' real account
  if Rails.env == "development"
    provider :facebook, '226327037396547', '8367d544c64b1c3c3b55ff807c74fabb', {:iframe => true, :scope => "email,user_hometown,publish_stream,offline_access,manage_pages, user_about_me, user_birthday, user_interests, user_photos, user_website"}
  elsif Rails.env == "staging"
    provider :facebook, '242929185733501', 'a66d6e3973cefa07946503f3aef1cca7', {:iframe => true, :scope => "email,user_hometown,publish_stream,offline_access,manage_pages, user_about_me, user_birthday, user_interests, user_photos, user_website", :client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
  else
    provider :facebook, '218956201460694', '51b7eeef805ce7858fb312c3a444e5ad', {:iframe => true, :scope => "email,user_hometown,publish_stream,offline_access,manage_pages, user_about_me, user_birthday, user_interests, user_photos, user_website", :client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
  end
end

Twitter.configure do |config|
  config.consumer_key = "JCrZPH7NaE8ZDY5Yj1qA"
  config.consumer_secret = "ik0gfOBMdk0rE99dS5W6DhdWci9THaMrzI8BFDhY"
  config.oauth_token = "241146137-l0jQZzEKaYaKNFSZ05hzmEHYnPNfTihy9mLVhr8w"
  config.oauth_token_secret = "uBrA09rATDBtvQsZCKFf5vEmKOlBT9HvExzSNUF7NG4"
end