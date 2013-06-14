class Message < ActiveRecord::Base

  is_private_message

  validates_presence_of :body
  attr_accessor :to

  default_scope order("created_at DESC")

  scope :un_read, where(:read_at => nil)

  def self.total_on(date)
    where("date(created_at) = ?",date).count
  end

end
# == Schema Information
#
# Table name: messages
#
#  id                :integer(4)      not null, primary key
#  sender_id         :integer(4)
#  recipient_id      :integer(4)
#  sender_deleted    :boolean(1)      default(FALSE)
#  recipient_deleted :boolean(1)      default(FALSE)
#  subject           :string(255)
#  body              :text
#  read_at           :datetime
#  created_at        :datetime
#  updated_at        :datetime
#

