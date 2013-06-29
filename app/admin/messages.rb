ActiveAdmin.register Message do
  index as: :block do |message|
    div for: message, class: 'panel' do
      h3 do
        text = ''
        text << message.sender.username rescue nil
        text << ' to '
        text << message.recipient.username rescue nil
        link_to(text, admin_message_path(message)).html_safe
      end
      div class: 'panel_contents' do
        simple_format message.body
      end
    end
  end
end
