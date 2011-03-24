module UsersHelper
  def unread_messages_count
    content_tag(:span, current_user.received_messages.un_read.count.to_s, :class =>"message_count tipsy", :title => t(:messages_count, :count => current_user.received_messages.un_read.count ))
  end
end
