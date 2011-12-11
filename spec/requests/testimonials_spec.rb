require 'spec_helper'

feature "Testimonials" do

  background do
    @user = Factory(:user)
  end

  scenario "Create a new testimonial with valid data" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
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

  scenario "Create a new testimonial with invalid data" do
    visit(new_user_session_path)
    within("#user_new") do
      fill_in 'user_email', :with => @user.email
      fill_in 'user_password', :with => @user.password
    end
    click_button 'Login'
    current_path.should match edit_user_path(@user)
    page.should have_content('Logout')

    visit(new_testimonial_path)

    within('#new_testimonial') do
      fill_in 'testimonial_body' , :with => "Lorem ipsum dolor sit "
      click_button('testimonial_submit')
    end
    page.should have_content('Invalid Fields')
  end

end