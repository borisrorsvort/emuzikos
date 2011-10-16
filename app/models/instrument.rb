class Instrument < ActiveRecord::Base
  has_and_belongs_to_many :users
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
    
  def used_by_counter
    self.users.count
  end
  
end
