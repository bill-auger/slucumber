Feature: Sign up
  In order to get access to protected sections of the site
  As a client
  I want to be able to sign up

    Background:
      Given I am not logged in

    Scenario: Client signs up with valid client credentials
      When I sign up with valid client credentials
      Then I should see a successful sign up but unconfirmed message

    Scenario: Client signs up without a nick
      When I sign up without a nick
      Then I should see a missing nick message

    Scenario: Client signs up without password
      When I sign up without a password
      Then I should see a missing password message

    Scenario: Client signs up without password confirmation
      When I sign up without a password confirmation
      Then I should see a missing password confirmation message

    Scenario: Client signs up with mismatched password and confirmation
      When I sign up with a mismatched password confirmation
      Then I should see a mismatched password message
