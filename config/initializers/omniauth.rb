Rails.application.config.middleware.use OmniAuth::Builder do  
  
  require 'openid/store/filesystem'
  
  #provider :facebook, '226327037396547', '8367d544c64b1c3c3b55ff807c74fabb' real account
  provider :facebook, '226327037396547', '8367d544c64b1c3c3b55ff807c74fabb'
        
  provider :twitter, '76zeThKPzGSMABaPJRxfA', 'CLPWwv4ZUGe2hVth09JAzkvqi8veVbslb7bH3CavBY'
    
end