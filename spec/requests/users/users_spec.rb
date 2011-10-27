require 'spec_helper'

feature "Users", %q{
  In order to get access to protected sections of the site
  A user
  Should be able to sign in
} do

  background do
    @user = Factory.create(:user)
  end

  scenario "with correct credentials" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => 'test@emuzikos.com'
      fill_in 'user_password', :with => 'password'
    end
    find("#user_submit").click
    current_path.should match users_path
    page.should have_content('Logout')

  end

  scenario "with incorrect credentials" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => 'test@emuzikos.com'
      fill_in 'user_password', :with => 'wrongpassword'
    end
    find("#user_submit").click
    current_path.should match new_user_session_path
    page.should have_content('Invalid email or password.')
    page.should have_content('Login')
  end
end