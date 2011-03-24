module UsersHelper
  def unread_messages_count
    content_tag(:span, current_user.received_messages.un_read.count.to_s, :class =>"message_count")
  end
end
