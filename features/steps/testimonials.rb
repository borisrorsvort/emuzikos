class Spinach::Features::Testimonials < Spinach::FeatureSteps
  include Authentication

  step 'I go to the new testimonials page' do
    visit(new_testimonial_path)
  end

  step 'I submit the form' do
    within('#new_testimonial') do
      fill_in 'testimonial_body' , :with => "Lorem ipsum dolor sit amet, consectetuer adipiscing elitLorem ipsum dolor sit amet, consectetuer adipiscing elit"
      click_button('Submit')
    end
    page.should have_content('Add a new testimonial')
    current_path.should == testimonials_path
  end

  step 'it is approved' do
    @t = Testimonial.first
    @t.update_attribute(:approved, true)
  end

  step 'I should see the testimonial on the index page' do
    visit testimonials_path
    assert @t.approved == true
    page.should have_content @t.body
  end

  step 'I submit the form with invalid datas' do
    within('#new_testimonial') do
      fill_in 'testimonial_body' , :with => "Lorem ipsum dolor sit "
      click_button('Submit')
    end
  end

  step 'I should see an error message' do
    page.should have_content('Invalid Fields')
  end
end
