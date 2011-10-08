class PagesController < ApplicationController
  
  def homepage
    @testimonials = Testimonial.approved.last(3)
    render :layout => "home"
  end
  
  %w(about terms privacy).each do |section|
    define_method section do
      render :layout => "home"
    end
  end
  
end
