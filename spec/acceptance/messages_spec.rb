require 'spec_helper'

feature "Send a Message", :js => true do
  background do
    @user = create(:user)
    @sender = @user
    @recipient = create(:user)
    login_as(@user, :scope => :user)
  end

  scenario "to visible user" do
    visit(user_path(@recipient))
    fill_in 'Subject', :with => "HI from Belgium"
    fill_in 'Message', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    click_button('Submit')
    page.should have_content('Success')
    #todo should check if message exist
    # visit(user_messages_path(@sender, :mailbox => :sent))
  end

end
