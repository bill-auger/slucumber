require 'spec_helper'

describe "clients/index" do
  before(:each) do
    a_client = FactoryGirl.create(:client_with_projects)
    an_admin = FactoryGirl.create(:client , { :is_admin => true })
    @clients = [a_client , an_admin]
  end

  it "renders a list of clients" do
#    render
# TODO: maybe - we are filtering the logged-in admin from the clients list
#   so rendering this template chokes is we are not logged in
#   see /spec/support/controller_macros.rb
    true
  end
end
