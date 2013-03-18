class Spinach::Features::UserSessionsLogin < Spinach::FeatureSteps
  include Authentication

  step 'I submit the form with correct credentials' do
    current_user = FactoryGirl.create(:user)
    fill_in "Email", with: current_user.email
    fill_in "Password", with: current_user.password
    click_button "Log in"
  end

  step 'I login with facebook' do
    visit "/users/auth/facebook"
    fill_in "Email", with: 'nalweko_fergiewitz_1363645864@tfbnw.net'
    fill_in "Password", with: "cacacaca"
  end

  step 'Then I should be the profile edit page' do
    page.should have_content 'Edit your profile'
  end
end

