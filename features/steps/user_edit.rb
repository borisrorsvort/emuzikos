class Spinach::Features::UserEdit < Spinach::FeatureSteps
  include Authentication

  step 'I submit the form with a genre' do
    @genre = FactoryGirl.create(:genre)
    click_button('Update')
    page.execute_script("$('#user_genre_ids').val(1).trigger('liszt:updated');")
    click_button('Update')
    page.should have_content('Success')
  end

  step 'I should see the genre' do
    visit user_path(@current_user)
    page.should have_content @genre.translated_name
  end

  step 'I submit the form with a instrument' do
    @instrument = FactoryGirl.create(:instrument)
    click_button('Update')
    page.execute_script("$('#user_instrument_ids').val(1).trigger('liszt:updated');")
    click_button('Update')
    page.should have_content('Success')
  end

  step 'I should see the instrument' do
    visit user_path(@current_user)
    page.should have_content @instrument.translated_name
  end

end
