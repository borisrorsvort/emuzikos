module Authentication
  extend ActiveSupport::Concern

  included do
    include PathHelper
    include Utils

    step 'I am logged in' do
      @current_user = FactoryGirl.create(:user)
      login_as(@current_user, :scope => :user)
    end

    step 'I login as the other user' do
      login_as(@user2, :scope => :user)
    end

    step 'I logout' do
      visit "/users/sign_out"
      save_and_open_page
    end

    step 'a second user exists' do
      @user2 = FactoryGirl.create(:user)
    end

    # def login_as(user = nil)
    #   visit user_session_path
    #   # find(:xpath, '//a[@class="normal_login_trigger"]').click
    #   page.execute_script('$(".collapse").collapse()')
    #   fill_in "Email", with: user.email
    #   fill_in "Password", with: user.password
    #   click_button "Log in"
    #   current_path.should == edit_user_path(user)
    # end
  end
end
