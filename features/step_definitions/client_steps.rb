### BACKGROUND STEPS ###

Given /^I am on the "My Projects" page$/ do
  step 'I exist as a client with 3 projects'
  step 'I am not logged in'
  step 'I log in with valid client credentials'
end

Given /^I am on the "Edit Project" page$/ do
  step 'visit "/projects/1/edit"'
end

Given /^I am on the "New Project" page$/ do
  step 'I am on the "My Projects" page'
  step 'I click "New Project"'
end


### WHEN ###

When(/^I log in with valid client credentials$/) { new_client ; sign_in(@client_params) }


### THEN ###

Then /^I should see my name in the banner in green$/ do
  page.should have_content @client.nick.gsub('.' , ' ')
end

# projects view

Then(/^I should see a button for each project name$/) do
  @client.projects.each do | project |
    page.should have_button project.name
  end
end

Then(/^I should see a column with each project description$/) do
  @client.projects.each do | project |
    page.should have_content project.desc
  end
end

# project view

Then(/^I should see a row for each event$/) do
  n_rows = @client.projects.last.events.size + 1 # "Add Event" button is always the last row
  find_by_id('project_events').all('tr').size.should be n_rows
end
