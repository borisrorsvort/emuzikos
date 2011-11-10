require 'spec_helper'

feature "Testimonials" do

  background do
    @user = Factory.create(:user)
  end

  scenario "Create a new testimonial" do
    visit(new_user_session_path)

    within("#user_new") do
      fill_in 'user_email', :with => 'test@emuzikos.com'
      fill_in 'user_password', :with => 'password'
    end

    click_button 'Login'

    current_path.should match edit_user_path(@user)
    page.should have_content('Logout')

    visit(new_testimonial_path)
    within('#new_testimonial') do
      fill_in 'testimonial_body' , :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elitLorem ipsum dolor sit amet, consectetuer adipiscing elit"
      click_button('testimonial_submit')
    end

    page.should have_content('Success')

  end

end