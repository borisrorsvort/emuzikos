class Testimonial < ActiveRecord::Base
  attr_accessible :body
  belongs_to :user
  validates_size_of :body, :within => 30...1300
  
  def self.total_on(date)  
    where("date(created_at) = ?",date).count  
  end
end
