require 'spec_helper'
require 'acceptance/acceptance_helper'

feature "Users", %q{
  In order to get access to protected sections of the site
  A user
  Should be able to sign in
} do

  background do
    @user = Factory(:user)
  end

  scenario "Signing in with correct credentials" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => 'test@emuzikos.com'
      fill_in 'user_password', :with => 'password'
    end
    click_link 'Login'
  end
end