class Message < ActiveRecord::Base

  is_private_message

  attr_accessor :to 
  
  scope :un_read, where(:read_at => nil)
  
  def self.total_on(date)  
    where("date(created_at) = ?",date).count  
  end
  
end