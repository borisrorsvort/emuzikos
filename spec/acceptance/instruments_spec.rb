require 'spec_helper'

#need js true because the checkbox are not loaded properly if Uniform is not loaded
feature "Instrument", :js => true do

  background do
    do_login_if_not_already
    @instrument = Factory.create(:instrument)
  end
  
  scenario "Adding one instrument to the user profile", :js => true do
    visit(edit_user_path(@user))
    save_and_open_page
    click('user_instrument_ids_chzn')
    click_button('Update')
    page.should have_content('Success')
    page.should have_content('Guitar')
  end

end