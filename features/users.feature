Feature: Users

  @selenium
  Scenario: I should see the list of users with completed profile
    Given I am logged in
    And I have a complete profile
    When I go to the users index page
    Then I should see my profile
