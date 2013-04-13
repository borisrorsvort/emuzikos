class Spinach::Features::Users < Spinach::FeatureSteps
  step 'there are many users with completed profile' do
    FactoryGirl.create(:user)
  end

  step 'I go to the users index page' do
    visit users_path
  end

  step 'I should see the list of users with completed profile' do
    within('.users_list') do
      User.all.each do |user|
        page.should have_content user.username
      end
    end
  end
end
