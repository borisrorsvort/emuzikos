class Instrument < ActiveRecord::Base
  has_many :users, :through => :skills
  has_many :skills, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  attr_accessible :name

  def used_by_counter
    self.users.count
  end

  def translated_name
    I18n.t(name, :scope => 'instruments')
  end
end

# == Schema Information
#
# Table name: instruments
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

