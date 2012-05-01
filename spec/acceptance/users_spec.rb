require 'spec_helper'

feature "Change Profile", %q{
  In order to increase customer satisfaction
  As a user
  I want to manage my profile
} do

  background do
    @user = create(:user)
    @instrument = create(:instrument)
    @genre = create(:genre)

    visit(new_user_session_path)
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password
    click_button 'Log in'
    current_path.should match edit_user_path(@user)
    page.should have_content('Log out')

  end

  def select_from_chosen(item_text, options)
    field = find_field(options[:from])
    option_value = page.evaluate_script("$(\"##{field[:id]} option:contains('#{item_text}')\").val()")
    page.execute_script("$('##{field[:id]}').val('#{option_value}')")
    page.execute_script("$('##{field[:id]}').trigger('liszt:updated').trigger('change')")
  end

  scenario "Should be able to add a youtube video with a valid id", :js => true do
    page.should have_content('Log out')
    visit(edit_user_path(@user))
    select_from_chosen(@genre.translated_name, :from => "user_genre_ids")
    select_from_chosen(@instrument.translated_name, :from => "user_instrument_ids")
    fill_in 'user_youtube_video_id', :with => "vP1x2DbS55E"
    click_button 'Update'
    page.should have_content "Success"
  end

  scenario "Should not be able to add a youtube video with a invalid id", :js => true do   
    visit(edit_user_path(@user))
    fill_in 'user_youtube_video_id', :with => "vP1xbS55E"
    click_button 'Update'
    #save_and_open_page
    page.should have_content "Error"
  end

end
