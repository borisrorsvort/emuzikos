class User < ActiveRecord::Base
  USER_TYPES = %w(band musician)
  INSTRUMENTS = %w( guitar bass double_bass drums violin flute piano percussions voice turntables banjo cithar bouzouki mandolin whistles spoons keyboard ocarina congas )
  
  acts_as_authentic
  #attr_accessible :username, :email, :password, :password_confirmation, :user_type, :instruments, :references, :zip, :country, :searching_for, :request_message
  
  def instruments
    instruments = []
    INSTRUMENTS.each do |instrument|
      instruments << instrument if self.send("#{instrument}?")
    end
    return instruments
    
  end
  
end
