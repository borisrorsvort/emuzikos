require 'spec_helper'

feature "Sign in Users", %q{
  In order to get access to protected sections of the site
  A user
  Should be able to log in
} do

  background do
    @user = Factory(:user)
  end

  scenario "with correct credentials" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
    end
    click_button 'Log in'
    current_path.should match edit_user_path(@user)
    page.should have_content('Log out')
  end

  scenario "with incorrect credentials" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => 'wrongpassword'
    end
    click_button 'Log in'
    current_path.should match new_user_session_path
    page.should have_content('Invalid email or password.')
    page.should have_content('Log in')
  end
end

feature "Editing profile infos" do

  scenario "add a youtube video with a valid id" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
    end
    click_button 'Log in'
    current_path.should match edit_user_path(@user)
    page.should have_content('Log out')

    visit(edit_user_path(@user))

    fill_in 'youtube_video_id', :with => "vP1x2DbS55E"
    click_button 'Update'
    page.should have_content "Success"
  end

  scenario "add a youtube video with a invalid id" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
    end
    click_button 'Log in'
    current_path.should match edit_user_path(@user)
    page.should have_content('Log out')

    visit(edit_user_path(@user))

    fill_in 'youtube_video_id', :with => "vP1xbS55E"
    click_button 'Update'
    page.should have_content "Error"
  end

end