class User < ActiveRecord::Base
  USER_TYPES = %w(band musician)
  INSTRUMENTS = %w( guitar bass double_bass drums violin flute piano percussions voice turntables banjo cithar bouzouki mandolin whistles spoons keyboard ocarina congas )
  MUSIC_GENRES = %w(alternative blues children classical comedy country dance easy_listening electronic fusion gospel hip_hop instrumental jazz latino new_age opera pop r&b reggae rock songwriter soundtrack spoken_word vocal world )
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
