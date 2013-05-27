### UTILITY METHODS ###

def dump_html(html) ; html.split("\n").each do | ea | ; p ea ; end ; end ;
PASSES = { :password => "changeme" , :password_confirmation => "changeme" }

def format_nick(nick) ; nick.nick.gsub('.' , ' ') ; end ;

def new_client
  @client_params ||= PASSES.merge({ :nick => "TheNewGuy" , :landmark => "http://goo.gl" , :notes => 'im kewl' })
end

def new_admin
  @admin_params ||= PASSES.merge({ :nick => "TheMan" , :is_admin => true })
end

def new_other_admin
  @other_admin_params ||= PASSES.merge({ :nick => "TheOtherMan" , :is_admin => true })
end

def new_other_client
  @other_client_params ||= PASSES.merge({ :nick => "Ben Clobbered" , :landmark => '' , :notes => "yer kewl" })
end

def find_client ; @client ||= Client.where(:nick => @client_params[:nick]).first ; end ;

def find_admin ; @admin ||= Client.where(:nick => @admin_params[:nick]).first ; end ;

def find_other_admin ; @other_admin ||= Client.where(:nick => @other_admin_params[:nick]).first ; end ;

def delete_client ; find_client ; @client.destroy unless @client.nil? ; end ;

def delete_admin ; find_admin ; @admin.destroy unless @admin.nil? ; end ;

def delete_other_admin ; find_other_admin ; @other_admin.destroy unless @other_admin.nil? ; end ;

def create_unconfirmed_client ; new_client ; delete_client ; sign_up ; sign_out ; end ;

def create_client
  new_client ; delete_client ;
  @client = FactoryGirl.create(:client_with_projects , @client_params.merge({ :n_projects => 3 }))
end

def create_admin
  new_admin ; delete_admin ;
  @admin = FactoryGirl.create(:client , @admin_params)
end

def create_other_admin
  new_other_admin ; delete_other_admin ;
  @other_admin = FactoryGirl.create(:client , @other_admin_params)
end

def sign_up
  delete_client
  visit '/clients/sign_up'
  fill_in 'client_nick' , :with => @client_params[:nick]
  fill_in 'client_password' , :with => @client_params[:password]
  fill_in 'client_password_confirmation' , :with => @client_params[:password_confirmation]
  click_button "Sign up" ; find_client ;
end

def sign_in(params)
  visit '/clients/sign_in'
  fill_in 'client_nick' , :with => params[:nick]
  fill_in 'client_password' , :with => params[:password]
  click_button "Sign in"
end

def sign_out ; visit '/clients/sign_out' ; end ;


### GIVEN ###

Given(/^I am not logged in$/) { sign_out }

Given(/^I am logged in$/) { create_client ; sign_in(@client_params) }

Given(/^I exist as a client$/) {create_client }

Given(/^I exist as an admin$/) { create_admin }

Given(/^I do not exist as a client$/) { new_client ; delete_client }

Given(/^I exist as an unconfirmed client$/) { create_unconfirmed_client }

Given(/^a client exists with 3 projects$/) { create_client }

#Given(/^a client exists with (\d+) projects$/) { | n_projects | ; create_client(n_projects) }

Given(/^another admin exists$/) { create_other_admin }


### WHEN ###

When(/^I log in with valid client credentials$/) { new_client ; sign_in(@client_params) }

When(/^I log in with valid admin credentials$/) { new_admin ; sign_in(@admin_params) }

When(/^I log out$/) { sign_out }

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

When(/^I return to the site$/) { visit '/' }

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

When(/^I go to the "(.*?)" page$/) { | page_name | ; visit path_to(page_name) }


### THEN STATES ###

Then /^I should be logged in$/ do
  page.should have_content "Settings"
  page.should have_content "Logout"
  page.should_not have_content "Sign up"
  page.should_not have_content "Login"
  page.should have_content @client_params[:nick].gsub('.' , ' ')
end

Then /^I should be logged out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Settings"
  page.should_not have_content "Logout"
  page.should_not have_content @client_params[:nick].gsub('.' , ' ')
end


### THEN MESAGES ###

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
end

Then /^I should see an account edited but unconfirmed message$/ do
  page.should have_content I18n.t('devise.registrations.update_needs_confirmation')
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

Then /^I should see a client updated message$/ do
  page.should have_content "Client was successfully updated."
end

Then(/^I should see a client deleted message$/) do
  page.should have_content "Client was successfully destroyed."
end


### THEN DOM ###

Then /^I should see my name$/ do
  page.should have_content @client.nick.gsub('.' , ' ')
end

Then /^I should see my name in red in the banner$/ do
  (page.find('span.adminLogin' , :text => format_nick(@admin))).should_not be_nil
end

Then /^I should see a header with the client name$/ do
  page.has_selector? 'h2' , :text => @client.nick.gsub('.' , ' ')
end

Then /^I should see a header with the number of projects$/ do
  page.has_selector? 'th' , :text => @client.projects.size.to_s + " Projects"
end

Then /^I should see a header with "(.*?)"$/ do | field |
  page.has_selector? 'th' , :text => field
end

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

Then /^I should see a "(.*?)" with "(.*?)"$/ do | tag , text |
  page.has_selector? tag , :text => text
end

Then(/^I should see "(.*?)"$/) do | text |
  page.should have_content text
end

Then /^I should see a table with the client projects$/ do
  @client.projects.each do | project |
    page.should have_button project.name
    page.should have_content project.desc
  end
end

Then(/^I should see a field for "(.*?)"$/) { | field | ; page.has_field? field }

Then /^I should see a field for "(.*?)" preset with "(.*?)"$/ do | field , text |
  page.has_field? field , :with => text
end


### THEN RESULTS ###

Then /^I should be on the "(.+)" page$/ do | page_name |
  URI.parse(current_url).path.should == path_to(case page_name
    when "Edit Client" ; "Edit Client " + @client.id.to_s ;
    when "Project"     ; "Project " + @client.projects.first.id.to_s ;
    else page_name
  end)
end

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
