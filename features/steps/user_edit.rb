class Spinach::Features::UserEdit < Spinach::FeatureSteps
  include Authentication

  step 'I submit the form with a genre' do
    @genre = FactoryGirl.create(:genre)
    @instrument = FactoryGirl.create(:instrument)
    select_from_chosen(@genre.translated_name, :from => "user_genre_ids")
    select_from_chosen(@instrument.translated_name, :from => "user_instrument_ids")
    click_button('Update')
    page.should have_content('Success')
  end

  step 'I should see the genre' do
    page.should have_content @genre.translated_name
  end

  step 'I submit the form with a instrument' do
    @genre = FactoryGirl.create(:genre)
    @instrument = FactoryGirl.create(:instrument)
    select_from_chosen(@genre.translated_name, :from => "user_genre_ids")
    select_from_chosen(@instrument.translated_name, :from => "user_instrument_ids")
    click_button('Update')
    page.should have_content('Success')
  end

  step 'I should see the instrument' do
    page.should have_content @instrument.translated_name
  end

end
