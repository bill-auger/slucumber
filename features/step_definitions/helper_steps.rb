### HEPLERS ###

def dump_html(html) ; html.split("\n").each do | ea | ; p ea ; end ; end ;
PASSES = { :password => "changeme" , :password_confirmation => "changeme" }

def format_nick(nick) ; nick.nick.gsub('.' , ' ') ; end ;


# dom and page maps

def any_button_text(btn_text)
  btns = {  'Client'          => @client.nick ,
            'Project'         => "#{@client.projects.last.name} (#{@client.projects.last.id})" ,
            'Destroy Project' => "Destroy " + @client.projects.first.name } # TODO: less than ideal - i wanted all named "Destroy Project" - but these are hard to nail down
  btns[btn_text] || btn_text
end

def the_button_text(btn_text)
  btns = { 'Client Projects' => @client.nick + " Projects" ,
           'Destroy Client'  => "Destroy " + @client.nick }
  btns[btn_text] || btn_text
end

def the_page_name(page_name)
  case page_name
    when 'Edit Client'  ; "Edit Client " + @client.id.to_s ;
    when 'Edit Project' ; "Edit Project " + @client.projects.last.id.to_s ;
    when 'Show Project' ; "Show Project " + @client.projects.last.id.to_s ;
    else page_name
  end
end


# instance creation

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
  fill_in 'client_nick'                  , :with => @client_params[:nick]
  fill_in 'client_password'              , :with => @client_params[:password]
  fill_in 'client_password_confirmation' , :with => @client_params[:password_confirmation]
  click_button "Sign up" ; find_client ;
end

def sign_in(params)
  visit '/clients/sign_in'
  fill_in 'client_nick'     , :with => params[:nick]
  fill_in 'client_password' , :with => params[:password]
  click_button "Sign in"
end

def sign_out ; visit '/clients/sign_out' ; end ;


### GIVEN ###

Given(/^I am not logged in$/) { sign_out }

Given(/^I am logged in$/) { create_client ; sign_in(@client_params) }

Given(/^I exist as a client$/) { create_client }

Given(/^I exist as a client with 3 projects$/) { create_client }

#Given(/^I exist as a client with (\d+) projects$/) { | n | ; create_client(n) }

Given(/^I exist as an admin$/) { create_admin }

Given(/^I do not exist as a client$/) { new_client ; delete_client }

Given(/^I exist as an unconfirmed client$/) { create_unconfirmed_client }

Given(/^a client exists with 3 projects$/) { create_client }

#Given(/^a client exists with (\d+) projects$/) { | n | ; create_client(n) }

Given(/^another admin exists$/) { create_other_admin }


### WHEN ###

When(/^I log out$/) { sign_out }

When(/^I return to the site$/) { visit '/' }

When(/^I go to the "(.*?)" page$/) { | page_name | ; visit path_to(page_name) }

When(/^I type "(.*?)" into the "(.*?)" field$/) do | text , field |
  fill_in field , :with => text
end

When(/^I click the "(.*?)" link$/) { | text | ; click_link text }

When(/^I click any "(.*?)" button$/) do | btn_text |
  step 'I click the "' + any_button_text(btn_text) + '" button'
end

When(/^I click the "(.*?)" button$/) do | btn_text |
p "current_url=" + current_url + " btn_text=" + btn_text + " clicking=" + the_button_text(btn_text)
#dump_html(page.body) if current_url == "http://www.example.com/clients/3/edit"

  click_button the_button_text(btn_text)

#p "current_url=" + current_url
end

When(/^I click "(.*?)"$/) { | text | ; click_on text }


### THEN DOM ###

Then /^I should be logged out$/ do
  page.should have_content "Sign up"
  page.should have_content "Login"
  page.should_not have_content "Settings"
  page.should_not have_content "Logout"
  page.should_not have_content @client_params[:nick].gsub('.' , ' ') if @client_params
  page.should_not have_content @admin_params[:nick].gsub('.' , ' ') if @admin_params
  page.should_not have_content @other_client_params[:nick].gsub('.' , ' ') if @other_client_params
  page.should_not have_content @other_admin_params[:nick].gsub('.' , ' ') if @other_admin_params
end

Then /^I should be on the "(.+)" page$/ do | page_name |
  URI.parse(current_url).path.should == path_to(the_page_name(page_name))
end

Then /^I should see a header with "(.*?)"$/ do | text |
  page.has_selector? 'th' , :text => text
end

Then(/^I should see a table for "(.*?)"$/) { | id | ; page.has_table? id }

Then(/^I should see a field for "(.*?)"$/) { | id | ; page.has_field? id }

Then /^I should see a field for "(.*?)" preset with "(.*?)"$/ do | id , text |
  page.has_field? id , :with => text
end

Then /^I should see a "(.*?)" with "(.*?)"$/ do | tag , text |
  page.has_selector? tag , :text => text
end

Then(/^I should see "(.*?)"$/) do | text |
  page.should have_content text
end

Then(/^I should not see "(.*?)"$/) do | text |
  page.should_not have_content text
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
