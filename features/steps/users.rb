class Spinach::Features::Users < Spinach::FeatureSteps
  include Authentication
  step 'there are many users with completed profile' do
    FactoryGirl.create(:user)
  end

  step 'I go to the users index page' do
    visit users_path
  end

  step 'I have a complete profile' do
    visit("/users/#{@current_user.slug}/edit")
    @genre = FactoryGirl.create(:genre)
    @instrument = FactoryGirl.create(:instrument)
    click_button('Update')
    page.execute_script("$('#user_genre_ids').val(1).trigger('liszt:updated');")
    page.execute_script("$('#user_instrument_ids').val(1).trigger('liszt:updated');")
    click_button('Update')
    page.should have_content('Success')
  end

  step 'I should see my profile' do
    within('.users_list') do
      page.should have_content @current_user.username.upcase
    end
    # @current_user.profile_completed.should == true
  end
end
