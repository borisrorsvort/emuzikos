module PathHelper
  extend ActiveSupport::Concern

  included do
    # Visit page

    step 'I go to the login page' do
      visit user_session_path
    end

    step 'I got to the registration page' do
      visit new_user_registration_path
    end

    step 'I got to the manage account page' do
      visit("/users/edit.#{@current_user.slug}")
    end

    #  Checking paths

    step 'I should be on the profile edit page' do
      page.should have_content 'Edit your profile'
    end

    step 'I should be on the home page' do
      current_path.should == "/"
    end

  end
end
