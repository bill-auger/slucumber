Feature: Site should require authentication
So that projects can be associated with clients and private
As a Client I should be able to login to access my projects

  Scenario: Client logs in successfully
    Given I exist as a client
      And I am not logged in
    When I log in with valid client credentials
    Then I see a successful sign in message
    When I return to the site
    Then I should be logged in as a client

  Scenario: Client enters wrong nick
    Given I exist as a client
      And I am not logged in
    When I log in with a wrong nick
    Then I see an invalid login message
      And I should be logged out

  Scenario: Client enters wrong password
    Given I exist as a client
      And I am not logged in
    When I log in with a wrong password
    Then I see an invalid login message
      And I should be logged out

  Scenario: Client is not signed up
    Given I do not exist as a client
    When I log in with valid client credentials
    Then I see an invalid login message
      And I should be logged out

  Scenario: Client is signed up but is unconfirmed
    Given I exist as an unconfirmed client
    When I log in with valid client credentials
    Then I see an unconfirmed message
      And I should be logged out
