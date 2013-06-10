Feature: Client can manage projects
So that I have some reason to use this website
As a Client I should be able to create , edit , and delete projects

  Scenario: Clients can see a list of their projects
    Given I exist as a client with 3 projects
      And I am not logged in
    When I log in with valid client credentials
    Then I should be on the "My Projects" page
      And I should see my name in the banner in green
      And I should see a "header" with "My Slucumber Projects"
      And I should see a "button" with "New Project"
      And I should see a button for each project name
      And I should see a column with each project description
      And I should see a "button" with "Update Project"
      And I should see a "button" with "Destroy Project"

  Scenario: Client can create a new project
    Given I am on the "My Projects" page
      When I click "Create New Project"
    Then I should be on the "New Project" page
      And I should see "Project Name:"
      And I should see a field for "project_name"
      And I should see "Description:"
      And I should see a field for "project_desc"

  Scenario: Client can name a new project
    Given I am on the "New Project" page
      When I type "My Nifty New Project" into the "project_name" field
      And I click "Create Project"
    Then I should be on the "Edit Project" page
      And I should see a header with "My Nifty New Project"
      And I should see a "button" with "Update Changes"
      And I should see a "button" with "Cancel Changes"
      And I should see a table for "project_events"
      And I should see a row for each event
      And I should see "Notes:"
      And I should see a field for "project_notes"
