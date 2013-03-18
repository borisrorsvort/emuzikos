Feature: Messages management

  Background:
    Given I am logged in
    And a second user exists

  @now
  Scenario: I should be able to send a message a to visible user
    Given I go to the other visible user page
    And I submit the message form
    Then I should see the success notification
    And I go to my sentbox
    And I should see the message in my send box

  @now
  Scenario: I should be able to delete a message
    Given I have sent a message
    And I go to my sentbox
    And I delete the message
    Then I should not see the message

  @now
  Scenario: I should be able to reply to a message
    Given I have sent a message
    And I login as the other user
    And I go to the message reply page
    And I submit the reply form
    Then I should see the success notification
    And I should see the reply in my inbox
