class Testimonial < ActiveRecord::Base
  belongs_to :user
  validates_size_of :body, :within => 30...1300

  delegate :username, :to => :user, :prefix => true

  attr_accessible :body, :approved

  scope :approved, where(:approved => true)
  scope :unapproved, where(:approved => false)

  def self.total_on(date)
    where("date(created_at) = ?",date).count
  end

  def approve
    self.approved = true
    self.save!
  end
end

# == Schema Information
#
# Table name: testimonials
#
#  id         :integer(4)      not null, primary key
#  body       :text
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  approved   :boolean(1)      default(FALSE)
#

