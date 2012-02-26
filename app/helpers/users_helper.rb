module UsersHelper
  def unread_messages_count
    content_tag(:span, current_user.received_messages.un_read.count.to_s, :class =>"message_count tooltip", :title => t(:messages_count, :count => current_user.received_messages.un_read.count ))
  end
  def searching_for_grouped_options
  	localized_types = User::USER_TYPES.map{|type| [ I18n.t(:"users.types.#{type}"), type ]}
  	localized_instruments = Instrument.all.collect{|i| [ I18n.t(:"instruments.#{i.name}"), i.name ]}
    grouped_options = [[t(:'activerecord.attributes.user.user_type'), localized_types ], [t(:'activerecord.attributes.user.instruments'), localized_instruments]]
  end
end
