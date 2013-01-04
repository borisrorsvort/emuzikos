require 'spec_helper'

feature "Message" do
  background do
    @user = create(:user)
    @sender = @user
    @recipient = create(:user)
    login_as(@user, :scope => :user)
  end

  scenario "send to visible user" do
    visit(user_path(@recipient))
    fill_in 'message_subject', :with => "HI from Belgium"
    fill_in 'message_body', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    click_button('Submit')
    page.should have_content('Success')
    visit(user_messages_path(@sender, :mailbox => :sent))
    within('.message') do
      click_link('HI from Belgium')
    end
    page.should have_content(@recipient.username)
  end

  scenario "delete a message" do
    visit(user_path(@recipient))
    fill_in 'message_subject', :with => "HI from Belgium"
    fill_in 'message_body', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    click_button('Submit')
    visit(user_messages_path(@sender, :mailbox => :sent))
    page.should have_selector('tr.message')
    check('delete_')
    click_button('Delete')
    page.should have_no_selector('tr.message')
  end

  scenario 'reply to a message' do
    visit(user_path(@recipient))
    fill_in 'message_subject', :with => "HI from Belgium"
    fill_in 'message_body', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    click_button('Submit')
    logout(@user)
    login_as(@recipient, :scope => :user)
    visit(user_messages_path(@recipient, :mailbox => :inbox))
    within('.message') do
      click_link('HI from Belgium')
    end
    click_link('Reply')
    find_field('message_subject').value.should == "Re: HI from Belgium"
    find_field('message_body').value.should have_content("*Original message*")
    click_button('Submit')
    page.should have_content('Success')
  end
end
