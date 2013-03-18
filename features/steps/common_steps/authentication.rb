module Authentication
  extend ActiveSupport::Concern

  included do
    include PathHelper
    include Utils

    step 'I have an account' do
      @current_user = FactoryGirl.create(:user)
    end

    step 'I am logged in' do
      login_as(@current_user)
    end

    def login_as(user = nil)
      visit user_session_path
      find(:xpath, '//a[@class="normal_login_trigger"]').click
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      current_path.should == edit_user_path(user)
    end
  end
end
