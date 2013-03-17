class Spinach::Features::UserSessionsLogin < Spinach::FeatureSteps
  include Authentication

  step 'I submit the form with correct credentials' do
    fill_in "Email", with: @current_user.email
    fill_in "Password", with: @current_user.password
    click_button "Log in"
  end

  step 'I should be the profile edit page' do
    current_path.should == edit_user_path(@current_user)
    page.should have_content 'Edit your profile'
  end


end
