class Spinach::Features::MessagesManagement < Spinach::FeatureSteps

  include Authentication
  include MessagesHelper

  step 'I go to the other visible user page' do
    visit "/users/#{@user2.slug}"
  end

  step 'I go to my inbox' do
    visit user_messages_path(@current_user)
  end

  step 'I go to the message reply page' do
    visit(user_messages_path(@user2, :mailbox => :inbox))
    click_link(@user1.username)
  end


  step 'I have sent a message' do
    visit(user_path(@user2))
    fill_in 'message_body', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    click_button('Submit')
  end

  step 'I delete the message' do
    page.should have_selector('.message')
    within('.message-delete-form') do
      find('.delete-button').click
    end
    page.should have_no_selector('.message')
  end

  step 'I should not see the message' do
    page.should have_no_selector('.message')
  end

  step 'I should see the reply in my inbox' do
    visit "/users/logout"
    login_as(@user1, :scope => :user)
    visit(user_messages_path(@current_user))
    within('.media.message') do
      page.should have_content @user2.username
    end
  end

  step 'I submit the message form' do
    page.execute_script("$('.nav-tabs-dark-profile li:last a').click();")
    fill_in 'message_body', :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    assert find_field('message_body').value == "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
    click_button('Submit')
  end

  step 'I submit the reply form' do
    find_field('message_body').value.should have_content("*Original message*")
    click_button('Submit')
  end



end
