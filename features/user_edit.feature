Feature: User edit

  Background:
    Given I have an account
    And I am logged in
    And I go to the profile edit page

  @now @javascript
  Scenario: I should be be able to add a instrument to my profile
    Given I submit the form with a genre
    Then I should see the genre

  @now @javascript
  Scenario: I should be be able to add a instrument to my profile
    Given I submit the form with a instrument
    Then I should see the instrument
