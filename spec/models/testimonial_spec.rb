require File.dirname(__FILE__) + '/../spec_helper'

describe Testimonial do
  it "should be valid" do
    Testimonial.new.should be_valid
  end
end
