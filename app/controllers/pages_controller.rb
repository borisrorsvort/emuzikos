class PagesController < ApplicationController
  before_filter :require_no_user, :only => [:about]
  
  def about
    
  end
  
  def contact
    if request.post? 
      Notifier.contact_email(params[:email]).deliver
      gflash :notice => "Your message was successfully sent. Thanks for your support!"
      #flash[:notice] = "seuccessfully send your message"
    end
  end
end
