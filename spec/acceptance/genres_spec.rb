require 'spec_helper'


#need js true because the checkbox are not loaded properly if Uniform is not loaded
feature "Genre", :js => true do

  background do
    @user = create(:user)
    @genre = create(:genre)
    @instrument = create(:instrument)
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

  scenario "Adding one instrument to the user profile", :js => true do
    visit(edit_user_path(@user))
    select_from_chosen(@instrument.translated_name, :from => "user_instrument_ids")
    select_from_chosen(@genre.translated_name, :from => "user_genre_ids")
    click_button('Update')
    page.should have_content('Success')
  end
end

