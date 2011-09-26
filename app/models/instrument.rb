class Instrument < ActiveRecord::Base
  # has_many :instruments_users, :dependent => :destroy
  #   has_many :users, :through => :instruments_users 
  has_and_belongs_to_many :users
end
