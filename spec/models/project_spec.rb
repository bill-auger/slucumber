require 'spec_helper'

describe Project do
  before do
    @a_client = FactoryGirl.create(:client)
    @a_name = "My Nifty Project" ; @a_desc = "desc" ; @some_notes = "notes" ;
    @minimal_params = { :name => @a_name  , :client_id => @a_client.id }
    @no_name_params = { :notes => @some_notes , :client_id => @a_client.id }
    @no_client_params = { :name => @a_name , :notes => @some_notes }
    @full_params = { :name => @a_name , :desc => @a_desc , :notes => @some_notes , :client_id => @a_client.id }
  end

  it "should create a Project when given only a name and client" do
    a_project = nil ; expect { a_project = Project.create(@minimal_params)
        }.to change { Project.count }.by(1)
    a_project.name.should == @a_name
    a_project.desc.should == ""
    a_project.notes.should == ""
    a_project.client.should == @a_client
    a_project.should be_kind_of(Project)
    a_project.should be_persisted
  end

  it "should create a Project with all fields set when given full params" do
    a_project = nil ; expect { a_project = Project.create(@full_params)
        }.to change { Project.count }.by(1)
    a_project.name.should == @a_name
    a_project.notes.should == @some_notes
    a_project.client.should == @a_client
    a_project.should be_kind_of(Project)
    a_project.should be_persisted
  end

  it "should not create a Project when given no name" do
    a_project = nil ; expect { a_project = Project.create(@no_name_params)
        }.to change { Project.count }.by(0)
    a_project.should be_kind_of(Project)
    a_project.should be_new_record
  end

  it "should not create a Project when given no Client" do
    a_project = nil ; expect { a_project = Project.create(@no_client_params)
        }.to change { Project.count }.by(0)
    a_project.should be_kind_of(Project)
    a_project.should be_new_record
  end

  it "should create a Project via a Client" do
    a_project = nil ; expect { a_project = @a_client.projects.create(@minimal_params)
    }.to change { Project.count }.by(1)
    @a_client.projects.should == [a_project]
    a_project.should be_kind_of(Project)
    a_project.should be_persisted
  end

  it "should create a new Project with 1 empty event via a Client" do
    a_project = @a_client.projects.create(@minimal_params)
    a_project.events.size.should be(1)
  end

end
