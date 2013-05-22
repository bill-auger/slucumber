### UTILITY METHODS ###

@newname = "newname"
@newpass = "newpass"

def create_noob
  @noob ||= { :nick => "TheNewGuy" ,
      :password => "changeme" , :password_confirmation => "changeme" }
end

def find_client
  @client ||= Client.where(:nick => @noob[:nick]).first
end

def create_unconfirmed_client
  create_noob
  delete_client
  sign_up
  sign_out
end

def create_client
  create_noob
  delete_client
  @client = FactoryGirl.create(:client , @noob)
end

def delete_client
  find_client ; @client.destroy unless @client.nil? ;
end

def sign_up
  delete_client
  visit '/clients/sign_up'
  fill_in "client_nick" , :with => @noob[:nick]
  fill_in "client_password" , :with => @noob[:password]
  fill_in "client_password_confirmation" , :with => @noob[:password_confirmation]
  click_button "Sign up"
  find_client
end

def sign_in
  visit '/clients/sign_in'
  fill_in "client_nick" , :with => @noob[:nick]
  fill_in "client_password" , :with => @noob[:password]
  click_button "Sign in"
end

def sign_out
  visit '/clients/sign_out'
end


### GIVEN ###

Given /^I am not logged in$/ do
  sign_out
end

Given /^I am logged in$/ do
  create_client
  sign_in
end

Given /^I exist as a client$/ do
  create_client
end

Given /^I do not exist as a client$/ do
  create_noob
  delete_client
end

Given /^I exist as an unconfirmed client$/ do
  create_unconfirmed_client
end


### WHEN ###

When /^I log in with valid credentials$/ do
  create_noob
  sign_in
end

When /^I log out$/ do
  sign_out
end

When /^I sign up with valid client data$/ do
  create_noob
  sign_up
end

When /^I sign up without a nick$/ do
  create_noob
  @noob = @noob.merge(:nick => "")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_noob
  @noob = @noob.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_noob
  @noob = @noob.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_noob
  @noob = @noob.merge(:password_confirmation => "differentpass")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I log in with a wrong nick$/ do
  @noob = @noob.merge(:nick => "DoIReallyExistAtAll")
  sign_in
end

When /^I log in with a wrong password$/ do
  @noob = @noob.merge(:password => "wrongpass")
  sign_in
end

When /^I change my name$/ do
  visit "/clients/edit"
  fill_in "client_nick" , :with => "newnick"
  click_button "Update changes"
end

When /^I change my password$/ do
  visit "/clients/edit"
  fill_in "client_password" , :with => "newpass"
  fill_in "client_password_confirmation" , :with => "newpass"
  click_button "Update changes"
end

When /^I change my name and password$/ do
  visit "/clients/edit"
  fill_in "client_nick" , :with => "newnick"
  fill_in "client_password" , :with => "newpass"
  fill_in "client_password_confirmation" , :with => "newpass"
  click_button "Update changes"
end

When /^I delete my account$/ do
  visit "/clients/edit"
  click_button "Delete my account"
end

When(/^I go to the "(.*?)" page$/) do | page_name |
  visit path_to(page_name)
end


### THEN ###
Then /^I should be logged in$/ do
  page.should have_content "Settings"
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
  page.should have_content @noob[:nick]
end

Then /^I should be logged out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Settings"
  page.should_not have_content "Logout"
  page.should_not have_content @noob[:nick]
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content I18n.t('devise.failure.unconfirmed')
end

Then /^I see a successful sign in message$/ do
  page.should have_content I18n.t('devise.sessions.signed_in')
end

Then /^I should see a successful sign up but unconfirmed message$/ do
  page.should have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')
end

Then /^I should see a missing nick message$/ do
  page.should have_content "Nick can't be blank"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a logged out message$/ do
  page.should have_content I18n.t('devise.sessions.signed_out')
end

Then /^I see an invalid login message$/ do
  page.should have_content I18n.t('devise.failure.not_found_in_database')
end

Then /^I should see an account edited message$/ do
  page.should have_content I18n.t('devise.registrations.updated')
#  page.should have_content I18n.t('devise.registrations.update_needs_confirmation')
# TODO: we would rather see the update_needs_confirmation messgae
#   but that wont be possible until we override Devise to use nick instead of email
end

Then /^I should see an account deleted message$/ do
  page.should have_content I18n.t('devise.registrations.destroyed')
end

Then(/^I see an unconfirmed message$/) do
  page.should have_content I18n.t('devise.failure.unconfirmed')
end

Then /^I should see a login required message$/ do
  page.should have_content I18n.t('devise.failure.unauthenticated')
end

Then /^I should see my nick$/ do
  create_client
  page.should have_content @client[:nick]
end

Then(/^I should see "(.*?)"$/) do | text |
  page.should have_content(text)
end

Then /^I should be on the "(.+)" page$/ do | page_name |
  URI.parse(current_url).path.should == path_to(page_name)
end

Then /^my name should be the new name$/ do
  @client[:name].should be(@newname)
end

Then /^my password should be the new password$/ do
  @client[:password].should be(@newpass)
end
