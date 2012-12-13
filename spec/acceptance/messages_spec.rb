require 'spec_helper'

feature "Send a Message", :js => true do
  background do
    @user = create(:user)
    @sender = @user
    @recipient = create(:user)
    visit(new_user_session_path)
    click_link 'normal_login_trigger'
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Log in'
    current_path.should match edit_user_path(@user)
    page.should have_content('Log out')
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
