class Testimonial < ActiveRecord::Base
  attr_accessible :body, :approved
  belongs_to :user
  validates_size_of :body, :within => 30...1300
  
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
