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
    click_button 'Login'
    current_path.should match edit_user_path(@user)
    page.should have_content('Logout')
  end

  scenario "with incorrect credentials" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => 'wrongpassword'
    end
    click_button 'Login'
    current_path.should match new_user_session_path
    page.should have_content('Invalid email or password.')
    page.should have_content('Login')
  end
end