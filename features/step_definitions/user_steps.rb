### WHEN ###

When(/^I sign up with valid client credentials$/) { new_client ; sign_up }

When /^I sign up without a nick$/ do
  new_client
  @client_params = @client_params.merge(:nick => "")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  new_client
  @client_params = @client_params.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  new_client
  @client_params = @client_params.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  new_client
  @client_params = @client_params.merge(:password_confirmation => "differentpass")
  sign_up
end

When /^I log in with a wrong nick$/ do
  sign_in(@client_params.merge(:nick => "DoIReallyExistAtAll"))
end

When /^I log in with a wrong password$/ do
  sign_in(@client_params.merge(:password => "wrongpass"))
end

When /^I change my name$/ do
  new_other_client
  visit "/clients/edit"
  fill_in "client_nick" , :with => @other_client_params[:nick]
  click_button "Update Changes"
end

When /^I change my password$/ do
  new_other_client
  visit "/clients/edit"
  fill_in "client_password" , :with => @other_client_params[:password]
  fill_in "client_password_confirmation" , :with => @other_client_params[:password]
  click_button "Update Changes"
end

When /^I change my name and password$/ do
  new_other_client
  visit "/clients/edit"
  fill_in "client_nick" , :with => @other_client_params[:nick]
  fill_in "client_password" , :with => @other_client_params[:password]
  fill_in "client_password_confirmation" , :with => @other_client_params[:password]
  click_button "Update Changes"
end

When(/^I delete my account$/) { visit "/clients/edit" ; click_button "Delete My Account" }


### THEN STATES ###

Then /^I should be logged in as a client$/ do
  page.should have_content "Settings"
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
  page.should have_content @client_params[:nick].gsub('.' , ' ')
end


### THEN RESULTS ###

Then /^my name should not be changed yet$/ do
  @client[:nick].should == @client_params[:nick]
end

# TODO: can we encrypt the pass to check this
#  @client[:password].should be @other_client_params[:password]
Then(/^my password should be the new password$/) { @client[:password].should be_nil }

Then /^I should see the updated details$/ do
  find('#client_landmark').value.should have_content @other_client_params[:landmark]
  find('#client_is_admin').should be_checked
  find('#client_notes').value.should have_content @other_client_params[:notes]
end
