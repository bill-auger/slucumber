Feature: Only Admins can do admin stuff
So that Admins can do admin stuff
As an Admin I should be able to do admin stuff

  Scenario: Admins can see the list of clients and admins
    Given I exist as an admin
      And another admin exists
      And a client exists with 3 projects
      And I am not logged in
    When I log in with valid admin credentials
    Then I should be on the "Clients" page
      And I should see my name in red in the banner
      And I should see a header with "Clients"
      And I should see a header with "Nick"
      And I should see a button with the client name in green
      And I should see a button with the admin name in red
      And I should see a header with "Landmark"
      And I should see a button with the client landmark
      And I should see a header with "Notes"
      And I should see a column with the client notes

  Scenario: Admins can follow the client landmark
    When I am on the "Clients" page
      And I click the landmark button (which webrat cant)
    Then I should be on the "Landmark" page

  Scenario: Admins can see client details
    When I am on the "Clients" page
      And I click the client button
    Then I should be on the "Edit Client" page
      And I should see a header with the client name
      And I should see a header with the number of projects
      And I should see a table with the client projects
      And I should see a button with the project name
      And I should see a "button" with "Destroy Project"
      And I should see a field for "Nick"
      And I should see a field for "Landmark"
      And I should see a field for "Is_admin"
      And I should see a field for "Notes"
      And I should see a "button" with "Update Client"
      And I should see a "button" with "Back"

  Scenario: Admins can edit client details
    When I am on the "Edit Client" page
      And I update the client details
      And I click "Update Client"
    Then I should see a client updated message
      And I should see the updated details
      And I should be on the "Edit Client" page

  Scenario: Admins can delete clients
    When I am on the "Edit Client" page
      And I click "Destroy Client"
    Then I should see a client deleted message
      And I should be on the "Clients" page

  Scenario: Admins can see a Client Project page
    When I am on the "Edit Client" page
      And I click the "Project" button
      Then I should be on the "Project" page
        And I should see a header with the project name
        And I should see a field for "Description"
        And I should see a field for "Notes"
        And I should see a "button" with "Update"
        And I should see a "button" with "Client Projects"

  Scenario: Admins can return to the Edit Client page
    When I am on the "Project" page
      And I click the "Client Projects" button
    Then I should be on the "Edit Client" page

  Scenario: Admins can delete a project
    When I am on the "Edit Client" page
      And I click any "Destroy Project" button
    Then I should see the client has 2 projects

#   Scenario: Admins can return to the Clients page
#     When I am on the "Edit Client" page
#       And I click the "Back" button
#     Then I should be on the "Clients" page
