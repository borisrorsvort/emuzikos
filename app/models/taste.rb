class Taste < ActiveRecord::Base
  belongs_to :genre
  belongs_to :user
end

# == Schema Information
#
# Table name: tastes
#
#  id         :integer(4)      not null, primary key
#  genre_id   :integer(4)
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

