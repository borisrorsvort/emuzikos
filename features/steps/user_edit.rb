class Spinach::Features::UserEdit < Spinach::FeatureSteps
  include Authentication

  step 'I submit the form with a genre' do
    @genre = FactoryGirl.create(:genre)
    @instrument = FactoryGirl.create(:instrument)
    select_from_chosen('#user_genre_ids', @genre.translated_name)
    select_from_chosen("#user_instrument_ids", @instrument.translated_name)
    click_button('Update')
    page.should have_content('Success')
  end

  step 'I should see the genre' do
    within('#user_genre_ids_chzn') do
      visible_in_chosen(@genre.translated_name)
    end
  end

  step 'I submit the form with a instrument' do
    @genre = FactoryGirl.create(:genre)
    @instrument = FactoryGirl.create(:instrument)
    select_from_chosen('#user_genre_ids', @genre.translated_name)
    select_from_chosen("#user_instrument_ids", @instrument.translated_name)
    click_button('Update')
    page.should have_content('Success')
  end

  step 'I should see the instrument' do
    within('#user_instrument_ids_chzn') do
      visible_in_chosen(@instrument.translated_name)
    end
  end

end
