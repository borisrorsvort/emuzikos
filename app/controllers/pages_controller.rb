class PagesController < ApplicationController
  def about
    
  end
  
  def contact
    if request.post? 
      Notifier.contact_email(params[:email]).deliver
      flash[:notice] = "seuccessfully send your message"
    end
  end
end
