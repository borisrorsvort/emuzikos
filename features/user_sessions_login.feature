Feature: User sessions login

  Background:
    Given I have a account

  Scenario: I should be be able to login with the correct credentials
    Given I go to the login page
    And I submit the form with correct credentials
    Then I should be the profile edit page

