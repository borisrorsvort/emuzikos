class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def index
    if params[:mailbox] == "sent"
      @messages = @current_user.sent_messages.order("created_at").page(params[:page]).per(AppConfig.site.results_per_page)
      mixpanel.track 'Message box view', {
        :box => "Sentbox"
      }
    else
      @messages = @current_user.received_messages.order("created_at").page(params[:page]).per(AppConfig.site.results_per_page)
      mixpanel.track 'Message box view', {
        :box => "Inbox"
      }
    end
    if request.xhr?
      render @messages
    end
  end

  def show
    @message = Message.read_message(params[:id], current_user)

    @reply_to = @message.sender.id

    @new_message = Message.new
    @new_message.body = "\n\n*Original message*\n\n #{@message.body}"
    @new_message.sender = @current_user
    @new_message.recipient = @message.sender
  end

  # def new
  #   @message = Message.new
  #   @old_message = Message.find(params[:old_message])
  #   @message.sender = @current_user
  #   @message.recipient = User.find(params[:reply_to])

  #   if params[:reply_to]
  #     @message.subject = "Re: #{@old_message.subject}"
  #     @message.body = "\n\n*Original message*\n\n #{@old_message.body}"
  #   end
  # end

  def create
    @message = Message.new(message_params)
    @message.sender = @current_user
    @message.recipient = User.find(params[:message][:to])

    respond_to do |format|
      if @message.save
        mixpanel.track 'Message created'

        format.html {
          # redirect_to :back, success: t('gflash.messages.create.success')
          redirect_to users_path, success: t('gflash.messages.create.success')
          gflash :success => true
        }
        format.js {
          flash.now[:success] = t('gflash.messages.create.success')
        }

        Notifier.user_message(@message, @current_user, @message.recipient).deliver if @message.recipient.prefers_message_notifications == true
      else
        format.html {
          redirect_to :back
          gflash :error => true
        }
        format.js {
          flash.now[:error] = t('gflash.messages.create.error')
        }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.mark_deleted(@current_user) unless @message.nil?

    redirect_to :back
  end

  def delete_selected
    if request.post?
      if params[:delete]
        params[:delete].each { |id|
          @message = Message.find(:first, :conditions => ["messages.id = ? AND (sender_id = ? OR recipient_id = ?)", id, @current_user, @current_user])
          @message.mark_deleted(@current_user) unless @message.nil?
        }
        gflash :success => true
      end
      redirect_to :back
    end
  end

  private

    def message_params
      params.require(:message).permit(:to, :body, :reply_to)
    end
end
