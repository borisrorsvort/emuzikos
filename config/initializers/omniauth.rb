Rails.application.config.middleware.use OmniAuth::Builder do  
  
  require 'openid/store/filesystem'
  
  #provider :facebook, '226327037396547', '8367d544c64b1c3c3b55ff807c74fabb' real account
  #provider :facebook, '226327037396547', '8367d544c64b1c3c3b55ff807c74fabb'
  #config for heroku
  config.omniauth :facebook, "226327037396547", "8367d544c64b1c3c3b55ff807c74fabb",
        {:scope => 'email, offline_access', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}}
        
  provider :twitter, '76zeThKPzGSMABaPJRxfA', 'CLPWwv4ZUGe2hVth09JAzkvqi8veVbslb7bH3CavBY'
    
end