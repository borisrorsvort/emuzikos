Feature: User sessions login

  Background:
    Given I am logged in

  Scenario: I should be be able to login with the correct credentials
    Given I logout
    And I go to the login page
    And I submit the form with correct credentials
    Then I should be on the profile edit page

