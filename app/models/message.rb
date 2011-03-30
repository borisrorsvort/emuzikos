class Message < ActiveRecord::Base

  is_private_message

  attr_accessor :to 
  
  scope :un_read, where(:read_at => nil)
  
  
end