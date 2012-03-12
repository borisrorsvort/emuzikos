require 'spec_helper'

feature "Send a Message" do
  background do
    do_login_if_not_already
    @sender = @user
    @recipient = Factory(:user)
  end

  scenario "to visible user", :js => true do
    visit(user_path(@recipient))
    click_link('Send a message')
    page.should have_content('New message')
    fill_in 'Subject', :with => "HI from Belgium"
    fill_in 'Message', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    click_button('Submit')
    page.should have_content('Success')
    visit(user_messages_path(@sender, :mailbox => :sent))
    page.should have_content('message')
    page.should have_content("#{@sender.username}")
  end

end
