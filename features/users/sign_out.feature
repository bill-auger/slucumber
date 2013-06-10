Feature: Sign out
  To protect my account from unauthorized access
  A logged in client
  Should be able to log out

  Scenario: Client signs out
    Given I am logged in
    When I log out
    Then I should see a logged out message
    When I return to the site
    Then I should be logged out
