class Instrument < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates_presence_of :name
  validates_uniqueness_of :name

  def used_by_counter
    self.users.count
  end

end
