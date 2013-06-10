### BACKGROUND STEPS ###

When /^I am on the "Clients" page$/ do
  step 'I exist as an admin'
  step 'another admin exists'
  step 'a client exists with 3 projects'
  step 'I am not logged in'
  step 'I log in with valid admin credentials'
end

When /^I am on the "Edit Client" page$/ do
  step 'I am on the "Clients" page'
  step 'I click any "Client" button'
end

When /^I am on the "Project" page$/ do
  step 'I am on the "Edit Client" page'
  step 'I click any "Project" button'
end


### WHEN ###

When(/^I log in with valid admin credentials$/) { new_admin ; sign_in(@admin_params) }

# clients view

When /^I click any landmark button \(which webrat cant\)$/ do
  # so we will just make sure that the form action has to the correct url
  landmark_tds = page.find('#clientsTable').all('td.clientLandmarkTd')
  landmark_td = (landmark_tds.select { | td | ; td.first('form.button_to') }).first
  landmark_form = landmark_td.first('form.button_to')
  landmark_form[:action].should == @client_params[:landmark]
  landmark_form[:method].should == "get"
  click_button @client.landmark
end

# client view

When /^I update the client details$/ do
  new_other_client
  fill_in 'client_landmark' , :with => @other_client_params[:landmark]
  check 'client_is_admin'
  fill_in 'client_notes' , :with => @other_client_params[:notes]
end


### THEN ###

Then /^I should see my name in red in the banner$/ do
  (page.find('span.adminLogin' , :text => format_nick(@admin))).should_not be_nil
end

# clients view

Then /^I should see a button with the client name in green$/ do
  page.should have_button format_nick(@client)
  begin
    adminLogin = page.find 'input.adminLogin' , { :text => format_nick(@client) }
  rescue Capybara::ElementNotFound
    adminLogin.should be_nil
  end
end

Then /^I should see a button with the admin name in red$/ do
  (adminLoginInput = page.find 'input.adminLogin').should_not be_nil
  adminLoginInput[:value].should == format_nick(@other_admin)
end

Then /^I should see a button with the client landmark$/ do
  page.should have_button @client.landmark
end

Then /^I should see a column with the client notes$/ do
  page.should have_content @client.notes
end

# client view

Then /^I should see a header with the client name$/ do
  page.has_selector? 'h2' , :text => @client.nick.gsub('.' , ' ')
end

Then /^I should see a header with the number of projects$/ do
  page.has_selector? 'th' , :text => @client.projects.size.to_s + " Projects"
end

Then /^I should see a table with the client projects$/ do
  @client.projects.each do | project |
    page.should have_button project.name
    page.should have_content project.desc
  end
end

# project view

Then(/^I should see a header with the project name$/) do
  page.has_selector? 'h2' , :text => @client.projects.first.name
end

Then(/^I should see a button with the project name$/) do
  page.should have_button @client.projects.first.name
end

Then(/^I should see the client has (\d+) projects$/) do | n_projects |
  @client.projects.size.should == n_projects.to_i
end
