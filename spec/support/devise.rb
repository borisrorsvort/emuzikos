RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
end

def do_login(options = {})
  @user = FactoryGirl.create(:user, options)
  visit(new_user_session_path)
  within("#user_new")  do
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
  end
  click_button 'Log in'
  current_path.should match edit_user_path(@user)
  page.should have_content('Log out')
end

# if we're already logged in, don't bother doing it again
def do_login_if_not_already(options = {})
  do_login(options) unless @user.present?
end