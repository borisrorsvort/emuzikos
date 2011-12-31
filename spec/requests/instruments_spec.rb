require 'spec_helper'

#need js true because the checkbox are not loaded properly if Uniform is not loaded
feature "Instrument", :js => true do

  background do
    @user = Factory(:user)
    @instrument = Factory.create(:instrument)
  end

  scenario "Adding one instrument to the user profile" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
    end
    click_button 'Log in'
    current_path.should match edit_user_path(@user)
    page.should have_content('Logout')

    visit(edit_user_path(@user))
    save_and_open_page
    page.should have_content(@instrument.name)
    page.should have_no_checked_field('user_instrument_ids_')

    check('user_instrument_ids_')
    click_button('Update')
    page.should have_content('Success')
    page.should have_checked_field('user_instrument_ids_')

  end

end