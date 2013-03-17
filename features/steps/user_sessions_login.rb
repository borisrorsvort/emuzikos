class Spinach::Features::UserSessionsLogin < Spinach::FeatureSteps
  include Authentication

  step 'I submit the form with correct credentials' do
    fill_in "Email", with: @current_user.email
    fill_in "Password", with: @current_user.password
    click_button "Log in"
  end

end
