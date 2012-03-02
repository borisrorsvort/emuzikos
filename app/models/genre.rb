class Genre < ActiveRecord::Base
  has_many :tastes, :dependent => :destroy
  has_many :users, :through => :tastes

  validates_presence_of :name
  validates_uniqueness_of :name

  def used_by_counter
    self.users.count
  end

  def translated_name
    I18n.t(name, :scope => 'musical_genres')
  end
end
