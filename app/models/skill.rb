class Skill < ActiveRecord::Base
  belongs_to :instrument
  belongs_to :user
end

# == Schema Information
#
# Table name: skills
#
#  id            :integer(4)      not null, primary key
#  instrument_id :integer(4)
#  user_id       :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

