require 'spec_helper'

describe Event do
  before do
    @a_name = "My Nifty Project"
    @a_project = FactoryGirl.create(:project)
    @no_actors_params = { :name => @a_name , :project_id => @a_project.id }
    @no_name_params = { :project_id => @a_project.id }
    @no_project_params = { :name => @a_name }
  end

  it "should create an Event when given a name and Project" do
    an_event = nil ; expect { an_event = Event.create(@no_actors_params)
        }.to change { Event.count }.by(1)
    an_event.should be_kind_of(Event)
    an_event.should be_persisted
  end

  it "should not create an Event when given a no name" do
    an_event = nil ; expect { an_event = Event.create(@no_name_params)
        }.to change { Event.count }.by(0)
    an_event.should be_kind_of(Event)
    an_event.should be_new_record
  end

  it "should not create an Event when given no Project" do
    an_event = nil ; expect { an_event = Event.create(@no_project_params)
        }.to change { Event.count }.by(0)
    an_event.should be_kind_of(Event)
    an_event.should be_new_record
  end

  it "should create an Event via a Project" do
    an_event = @a_project.events.build(@no_actors_params)
    expect { @a_project.save }.to change { Event.count }.by(1)
    @a_project.events.should == [an_event]
    an_event.should be_kind_of(Event)
    an_event.should be_persisted
  end

  it "should create an Event with Actors via a Project" do
    an_event = @a_project.events.build(@no_actors_params)
    expect { @a_project.save }.to change { Event.count }.by(1)
    expect {
# TODO: this is not the rails 'way'
      an_event.initiator = Initiator.create({ :name => "Fred" , :kind => USER_KIND , :event_id => an_event.id })
      an_event.trigger = Trigger.create({ :name => "Fred" , :kind => CLICK_KIND , :event_id => an_event.id })
      an_event.receiver = Receiver.create({ :name => "Fred" , :kind => OBJECT_KIND , :event_id => an_event.id })
      an_event.response = Response.create({ :name => "Fred" , :kind => CHECK_EMAIL_KIND , :event_id => an_event.id })
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
