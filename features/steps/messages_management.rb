class Spinach::Features::MessagesManagement < Spinach::FeatureSteps

  include Authentication
  include MessagesHelper

  step 'I go to the other visible user page' do
    visit "/users/#{@recipient.slug}"
  end

  step 'I go to my sentbox' do
    visit user_messages_path(@current_user, :mailbox => :sent)
  end

  step 'I go to the message reply page' do
    visit(user_messages_path(@recipient, :mailbox => :inbox))
    click_link('HI from Belgium')
    click_link('Reply')
  end

  step 'I should see the message in my send box' do
    click_link('HI from Belgium')
    page.should have_content(@recipient.username)
  end

  step 'I have sent a message' do
    visit(user_path(@recipient))
    fill_in 'message_subject', :with => "HI from Belgium"
    fill_in 'message_body', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    click_button('Submit')
  end

  step 'I delete the message' do
    page.should have_selector('tr.message')
    check('delete_')
    click_button('Delete')
    page.should have_no_selector('tr.message')
  end

  step 'I should not see the message' do
    page.should have_no_selector('tr.message')
  end

  step 'I should see the reply in my inbox' do
    visit "/users/logout"
    login_as(@current_user, :scope => :user)
    visit(user_messages_path(@current_user, :mailbox => :inbox))
    page.should have_content 'Re: HI from Belgium'
  end

  step 'I submit the message form' do
    fill_in 'message_subject', :with => "HI from Belgium"
    assert find_field('message_subject').value == "HI from Belgium"
    fill_in 'message_body', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    assert find_field('message_body').value == "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    click_button('Submit')
  end

  step 'I submit the reply form' do
    find_field('message_subject').value.should == "Re: HI from Belgium"
    find_field('message_body').value.should have_content("*Original message*")
    click_button('Submit')
  end



end
