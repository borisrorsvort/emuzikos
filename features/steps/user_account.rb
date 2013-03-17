class Spinach::Features::UserAccount < Spinach::FeatureSteps
  include Authentication

  step 'I submit the form' do
    fill_in "Username", with: "Boris"
    fill_in "Email", with: "1234@example.com"
    fill_in "Password", with: "1234AZERT"
    fill_in "Password confirmation", with: "1234AZERT"
    click_button "Submit"
  end

  step 'I delete my account' do
    click_link "Cancel my account"
  end

  step 'I should not be able to login' do
    visit user_session_path
    fill_in "Email", with: "1234@example.com"
    fill_in "Password", with: "1234AZERT"
    click_button "Log in"
    current_path.should == user_session_path
  end
end
