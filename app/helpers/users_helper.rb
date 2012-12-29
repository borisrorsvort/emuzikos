module UsersHelper
  def unread_messages_count
    content_tag(:span, current_user.received_messages.un_read.count.to_s, :class =>"badge badge-important")
  end
  def searching_for_grouped_options
  	localized_types = User::USER_TYPES.map{|type| [ I18n.t(:"users.types.#{type}"), type ]}
  	localized_instruments = Instrument.order("name ASC").all.collect{|i| [ i.translated_name, i.name ]}
    grouped_options = [[t(:'activerecord.attributes.user.user_type'), localized_types ], [t(:'activerecord.attributes.user.instruments'), localized_instruments]]
  end
  def i18n_country(user)
    Carmen::Country.coded(user.country).name
  end
end
