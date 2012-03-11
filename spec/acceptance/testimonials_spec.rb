require 'spec_helper'

feature "Testimonials" do

  background do
    do_login_if_not_already
  end

  scenario "Create a new testimonial with valid data", :js => true do
    visit(new_testimonial_path)
    within('#new_testimonial') do
      fill_in 'testimonial_body' , :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elitLorem ipsum dolor sit amet, consectetuer adipiscing elit"
      click_button('Submit')
    end
    page.should have_content('Success')
  end

  scenario "Create a new testimonial with invalid data", :js => true do
    visit(new_testimonial_path)
    within('#new_testimonial') do
      fill_in 'testimonial_body' , :with => "Lorem ipsum dolor sit "
      click_button('Submit')
    end
    page.should have_content('Invalid Fields')
  end

end