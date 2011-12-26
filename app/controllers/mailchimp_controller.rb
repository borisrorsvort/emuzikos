class MailchimpController < ApplicationController
  def callback
    logger.info "Called callback with: #{params.inspect}. Request: #{request.inspect}"
    requesttype = params[:type]
    data = params[:data]
    case requesttype
      when "unsubscribe"
        logger.info "Calling Unsubscribe from web callback for #{data[:email]}"
        unsubscribe(data)
      when "cleaned"
        logger.info "Calling Cleaned from web callback for #{data[:email]}"
        clean(data)
    end
    render :nothing => true, :status => 200
  end

protected
  def unsubscribe(data)
    user = User.find_by_email!(data[:email])
    user.update_attribute(:prefers_newsletters, false)
    logger.info "Mailchimp Webhook Unsubscribe: Unsubscribed user with email #{data[:email]}"
  rescue ActiveRecord::RecordNotFound
    logger.error "Mailchimp Webhook Unsubscribe: Could not find user with email #{data[:email]}"
  end

  def clean(data)
    user = User.find_by_email!(data[:email])
    user.update_attribute(:prefers_newsletters, false)
    logger.info "Mailchimp Webhook Clean: Unsubscribed user with email #{data[:email]}"
  rescue ActiveRecord::RecordNotFound
    logger.error "Mailchimp Webhook Clean: Could not find user with email #{data[:email]}"
  end
end
