module UsersHelper
  def unread_messages_count
    content_tag(:span, current_user.received_messages.un_read.count.to_s, :class =>"message_count tooltip", :title => t(:messages_count, :count => current_user.received_messages.un_read.count ))
  end
  def searching_for_grouped_options
    grouped_options = [['User Type', User::USER_TYPES], ['Instruments', Instrument.all.collect{|i| i.name}]]
  end
end
