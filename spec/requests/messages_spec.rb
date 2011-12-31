require 'spec_helper'

feature "Send a Message" do
  background do
    @sender = Factory(:user)
    @recipient = Factory(:user)
  end

  scenario "to visible user" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => @sender.email
      fill_in 'user_password', :with => @sender.password
    end
    click_button 'Log in'
    current_path.should match edit_user_path(@sender)
    page.should have_content('Logout')

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
