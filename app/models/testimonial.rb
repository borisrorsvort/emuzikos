class Testimonial < ActiveRecord::Base
  attr_accessible :body
  belongs_to :user
  validates_size_of :body, :within => 30...1300
end
