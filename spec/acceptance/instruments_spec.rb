require 'spec_helper'

#need js true because the checkbox are not loaded properly if Uniform is not loaded
feature "Instrument", :js => true do

  background do
    do_login_if_not_already
    @instrument = Factory.create(:instrument)
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
    click_button('Update')
    page.should have_content('Success')
  end

end