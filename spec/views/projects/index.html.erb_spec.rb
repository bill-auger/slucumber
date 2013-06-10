require 'spec_helper'

describe "projects/index" do
  before(:each) do
    projects = [ FactoryGirl.create(:project) , FactoryGirl.create(:project) ]
    assign(:projects , projects)
    assign(:longest_name , Project.display_projects(projects))
  end

  it "renders a list of projects" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
