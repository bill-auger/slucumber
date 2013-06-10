Feature: Site should require authentication
So that projects can be associated with clients and private
As a Client I should be required to login to access my projects

  Scenario: Unauthenticated visitors are redirected to the login page
    Given I am not logged in
    When I go to the "My Projects" page
    Then I should be on the "Login" page

  Scenario: Authenticated clients are redirected to the projects page
    Given I exist as a client
      And I am not logged in
    When I log in with valid client credentials
    Then I should be on the "My Projects" page

  Scenario: Authenticated admins are redirected to the clients page
    Given I exist as an admin
      And I am not logged in
    When I log in with valid admin credentials
    Then I should be on the "Clients" page
