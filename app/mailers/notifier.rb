class Notifier < ActionMailer::Base
  default :from => "info@emuzikos.com"
  default :charset => "utf-8"  
  def password_reset_instructions(user)
    @user = user
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Password Reset Instructions", :from => "noreply@emuzikos.com" )
  end
  
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.username} <#{user.email}>", :subject => "Registration confirmation", :from => "noreply@emuzikos.com" )         
  end
  
  def contact_email(email_params)
      # You only need to customize @recipients.
      @recipients = "contact@website.co.uk"
      @subject = email_params[:subject]
      @email_body = email_params[:body]
      @name = email_params[:name]
      @sender_email = email_params[:address]
      mail(:to => "Solar <info@emuzikos.com>", :subject => "Contact form", :from => "#{email_params[:name]} <#{email_params[:address]}>" )
  end
  
end
