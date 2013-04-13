Feature: Users
  Scenario: I should see the list of users with completed profile
    Given there are many users with completed profile
    When I go to the users index page
    Then I should see the list of users with completed profile
