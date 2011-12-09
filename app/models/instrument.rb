class Instrument < ActiveRecord::Base
  has_many :users, :through => :skills
  has_many :skills, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  def used_by_counter
    self.users.count
  end

end
