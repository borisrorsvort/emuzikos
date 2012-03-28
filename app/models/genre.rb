class Genre < ActiveRecord::Base
  has_many :tastes, :dependent => :destroy
  has_many :users, :through => :tastes

  validates_presence_of :name
  validates_uniqueness_of :name

  attr_accessible :name

  def used_by_counter
    self.users.count
  end

  def translated_name
    I18n.t(name, :scope => 'musical_genres')
  end
end

# == Schema Information
#
# Table name: genres
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

