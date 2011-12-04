require 'spec_helper'

describe Testimonial do

  before(:each) do
    @attr = {
      :body => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.",
      :user_id => 1
    }
  end

  it "should create a new instance given a valid attribute" do
    Testimonial.create!(@attr)
  end

  it "should not have empty body" do
    empty_body = Testimonial.new(@attr.merge(:body => ""))
    empty_body.should_not be_valid
  end

end