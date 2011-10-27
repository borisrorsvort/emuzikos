class Notifier < ActionMailer::Base
  default :charset => "utf-8"
  default :from => AppConfig.email.from, :charset => 'utf-8', :reply_to => AppConfig.email.do_not_reply_from
  default_url_options[:host] = "emuzikos.com"
  layout 'notifier'
  helper :users

  def contact_email(email_params)
      # You only need to customize @recipients.
      @recipients = "contact@website.co.uk"
      @subject = email_params[:subject]
      @email_body = email_params[:body]
      @name = email_params[:name]
      @sender_email = email_params[:address]
      mail(:to => "Solar <info@emuzikos.com>", :subject => "Contact form", :from => "#{email_params[:name]} <#{email_params[:address]}>" )
  end
  def user_message(message, user, recipient)
    @sender = user.username
    @title = "New message from #{@sender}"
    @recipient = recipient
    @message_url = user_message_url(recipient, message)
    mail(:to => @recipient.email,
          :subject => "You've got a new message on Emuzikos!")
  end

end
