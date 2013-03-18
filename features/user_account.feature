Feature: User account

  Scenario: I should be able to create an account
    Given I go to the registration page
    And I submit the form
    Then I should be on the profile edit page

  Scenario: I should be able to delete my account
    And I am logged in
    And I go to the manage account page
    And I delete my account
    Then I should be on the home page
    And I should not be able to login

