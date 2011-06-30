Rails.application.config.middleware.use OmniAuth::Builder do  
  
  require 'openid/store/filesystem'
  
  #provider :facebook, '226327037396547', '8367d544c64b1c3c3b55ff807c74fabb' real account
  if RAILS_ENV == "development"
    provider :facebook, '226327037396547', '8367d544c64b1c3c3b55ff807c74fabb'
  elsif RAILS_ENV == "staging"
    provider :facebook, '242929185733501', 'a66d6e3973cefa07946503f3aef1cca7', {:client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
  else
    provider :facebook, '226327037396547', '8367d544c64b1c3c3b55ff807c74fabb', {:client_options => {:ssl => {:ca_file => "/usr/lib/ssl/certs/ca-certificates.crt"}}}
  end
        
  provider :twitter, '76zeThKPzGSMABaPJRxfA', 'CLPWwv4ZUGe2hVth09JAzkvqi8veVbslb7bH3CavBY'
    
end