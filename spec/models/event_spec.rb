require 'spec_helper'

describe Event do
  before(:each) do
    @a_project = FactoryGirl.create(:project) ; @a_tag = "tagged event" ;
    @minimal_params = { :project_id => @a_project.id }
    @full_params  = { :project_id => @a_project.id , :tag => @a_tag }
    @no_project_params = {}
  end

  it "should create an Event when given a Project" do
    an_event = nil ; expect { an_event = Event.create(@minimal_params)
        }.to change { Event.count }.by(1)
    an_event.should be_kind_of(Event)
    an_event.should be_persisted
    an_event.project.id.should be @a_project.id
  end

  it "should create an Event when given a Project and a tag" do
    an_event = nil ; expect { an_event = Event.create(@full_params)
        }.to change { Event.count }.by(1)
    an_event.should be_kind_of(Event)
    an_event.should be_persisted
    an_event.project.id.should be @a_project.id
    an_event.tag.should == @a_tag
  end

  it "should not create an Event when given no Project" do
    an_event = nil ; expect { an_event = Event.create(@no_project_params)
        }.to change { Event.count }.by(0)
    an_event.should be_kind_of(Event)
    an_event.should be_new_record
  end

  it "should create an Event via a Project" do
    default_event = @a_project.events.first
    an_event = @a_project.events.build(@full_params)
    expect { @a_project.save }.to change { Event.count }.by(1)
    @a_project.events.should == [default_event , an_event]
    an_event.should be_kind_of(Event)
    an_event.should be_persisted
  end

  it "should create an Event and Actors via a Project" do
    an_event = @a_project.events.build(@full_params)
    expect { @a_project.save }.to change { Event.count }.by(1)
    expect {
      an_event.build_initiator({ :name => "Fred" , :kind => USER_KIND })
      an_event.build_trigger({ :name => "Fred" , :kind => CLICK_KIND })
      an_event.build_receiver({ :name => "Fred" , :kind => OBJECT_KIND })
      an_event.build_response({ :name => "Fred" , :kind => EMAIL_KIND })
      an_event.save
    }.to change { Actor.count }.by(4)
    an_event.initiator.should be_kind_of(Initiator)
    an_event.trigger.should be_kind_of(Trigger)
    an_event.receiver.should be_kind_of(Receiver)
    an_event.response.should be_kind_of(Response)
    an_event.initiator.should be_persisted
    an_event.trigger.should be_persisted
    an_event.receiver.should be_persisted
    an_event.response.should be_persisted
  end
end
