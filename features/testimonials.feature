Feature: Testimonials
  Background:
    Given I am logged in

  Scenario: Create a new testimonial with valid data
    Given I go to the new testimonials page
    And I submit the form
    And it is approved
    Then I should see the testimonial on the index page

  Scenario: Create a new testimonial with invalid data
    Given I go to the new testimonials page
    And I submit the form with invalid datas
    Then I should see an error message
