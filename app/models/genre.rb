class Genre < ActiveRecord::Base
  has_many :tastes, :dependent => :destroy
  has_many :users, :through => :tastes

  validates_presence_of :name
  validates_uniqueness_of :name
end
