class PagesController < ApplicationController
  
  def homepage
    @testimonials = Testimonial.last(3)
    render :layout => "home"
  end
  
  def about
    
  end
  
  def contact
    if request.post? 
      Notifier.contact_email(params[:email]).deliver
      gflash :success => true
      #flash[:notice] = "seuccessfully send your message"
    end
  end
end
