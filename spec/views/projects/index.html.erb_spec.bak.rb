require 'spec_helper'

describe "projects/index" do
  before(:each) do
    login_client
    client_attributes = { :client_id => subject.current_client.id }
    projects = [ FactoryGirl.create(:project , client_attributes) , FactoryGirl.create(:project , client_attributes) ]
    assign(:projects , projects)
    assign(:longest_name , Project.display_projects(projects))
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
