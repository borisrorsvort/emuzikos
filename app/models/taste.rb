class Taste < ActiveRecord::Base
  belongs_to :genre
  belongs_to :user
end
