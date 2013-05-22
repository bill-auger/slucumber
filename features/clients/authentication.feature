Feature: Site should require authentication
So that projects can be associated with clients and private
As a Client I should be required to login to access my projects

  Scenario: Unauthenticated users are redirected to the login page
    Given I am not logged in
    When I go to the "My Projects" page
    Then I should be on the "Login" page
      And I should see a login required message
