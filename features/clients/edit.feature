Feature: Edit Client
  As a registered client of the website
  I want to edit my client profile
  So I can change my name and/or password

  Background:
    Given I am not logged in

  Scenario: I log in and change my name
    Given I am logged in
    When I change my name
    Then I should see an account edited but unconfirmed message
      And my name should be the new name

  Scenario: I log in and change my password
    Given I am logged in
    When I change my password
    Then I should see an account edited message
      And my password should be the new password

  Scenario: I log in and change my name and password
    Given I am logged in
    When I change my name and password
    Then I should see an account edited but unconfirmed message
      And my name should be the new name
      And my password should be the new password

  Scenario: I log in and delete my account
    Given I am logged in
    When I delete my account
    Then I should see an account deleted message
      And I should be logged out