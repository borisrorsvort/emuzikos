Feature: User account

  Scenario: I should be able to create an account
    Given I got to the registration page
    And I submit the form
    Then I should be on the profile edit page
  @now
  Scenario: I should be able to delete my account
    Given I have an account
    And I am logged in
    And I got to the manage account page
    And I delete my account
    Then I should be on the home page
    And I should not be able to login

