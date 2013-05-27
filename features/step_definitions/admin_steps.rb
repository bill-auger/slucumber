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
  step 'I click the client button'
end

When /^I am on the "Project" page$/ do
  step 'I am on the "Edit Client" page'
  step 'I click the "Project" button'
end


### WHEN ###

When(/^I click the client button$/) { click_button @client.nick }

When /^I click the landmark button \(which webrat cant\)$/ do
  # so we will just make sure that the form action has to the correct url
  landmark_tds = page.find('#clientsTable').all('td.clientLandmarkTd')
  landmark_td = (landmark_tds.select { | td | ; td.first('form.button_to') }).first
  landmark_form = landmark_td.first('form.button_to')
  landmark_form[:action].should == @client_params[:landmark]
  landmark_form[:method].should == "get"
  click_button @client.landmark
end

When /^I update the client details$/ do
  new_other_client
  fill_in 'client_landmark' , :with => @other_client_params[:landmark]
  check 'client_is_admin'
  fill_in 'client_notes' , :with => @other_client_params[:notes]
end

When(/^I click any "Destroy Project" button$/) do
# TODO: less than ideal - i wanted all named "Destroy Project" - but these are hard to nail down
  page.find_button("Destroy " + @client.projects.first.name).click
end

When(/^I click the "(.*?)" link$/) { | text | ; click_link text }

When(/^I click the "(.*?)" button$/) do | btn_text |
  btns = { "Project" => @client.projects.first.name ,
           "Client Projects" => @client.nick + " Projects" }
  click_button btns[btn_text] || btn_text
#p "btn_text=" + btn_text + " clicking=" + (btns[btn_text] || btn_text)
end

When(/^I click "(.*?)"$/) { | text | ; click_on text }


### THEN ###

Then(/^I should see a header with the project name$/) do
  page.has_selector? 'h2' , :text => @client.projects.first.name
end

Then(/^I should see a button with the project name$/) do
  page.should have_button @client.projects.first.name
end

Then(/^I should see the client has (\d+) projects$/) do | n_projects |
  @client.projects.size.should == n_projects.to_i
end
