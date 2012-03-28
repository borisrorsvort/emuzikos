class Service < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid, :uname, :uemail
end

# == Schema Information
#
# Table name: services
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  provider   :string(255)
#  uid        :string(255)
#  uname      :string(255)
#  uemail     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

