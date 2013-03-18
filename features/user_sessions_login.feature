Feature: User sessions login

  Background:
    Given I logout

  Scenario: I should be be able to login with the correct credentials
    And I go to the login page
    And I submit the form with correct credentials
    Then I should be on the profile edit page

  @wip
  Scenario: I should be able to login with facebook
    Given I logout
    And I login with facebook
    Then I should be the profile edit page

