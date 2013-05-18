require 'spec_helper'

describe Actor do
  before do
    @an_event = FactoryGirl.create(:event)
    @a_name = "Fred"
    @a_kind = USER_KIND
    @no_name_params = { :kind => @a_kind , :type => "Trigger" , :event_id => @an_event.id }
    @no_kind_params = { :name => @a_name , :type => "Trigger" , :event_id => @an_event.id }
    @no_type_params = { :name => @a_name , :kind => @a_kind , :event_id => @an_event.id }
    @no_event_params = { :name => @a_name , :kind => @a_kind , :type => "Trigger" }
    @full_params = { :name => @a_name , :kind => @a_kind , :type => "Trigger" , :event_id => @an_event.id }
  end

  it "should create an Actor when given full params" do
    an_actor = nil ; expect { an_actor = Actor.create(@full_params)
        }.to change { Actor.count }.by(1)
    an_actor.should be_kind_of(Actor)
    an_actor.should be_persisted
  end

  it "should not create an Actor when given a no name" do
    an_actor = nil ; expect { an_actor = Actor.create(@no_name_params)
        }.to change { Actor.count }.by(0)
    an_actor.should be_kind_of(Actor)
    an_actor.should be_new_record
  end

  it "should not create an Actor when given a no kind" do
    an_actor = nil ; expect { an_actor = Actor.create(@no_kind_params)
        }.to change { Actor.count }.by(0)
    an_actor.should be_kind_of(Actor)
    an_actor.should be_new_record
  end

  it "should not create an Actor when given a no type" do
    an_actor = nil ; expect { an_actor = Actor.create(@no_type_params)
        }.to change { Actor.count }.by(0)
    an_actor.should be_kind_of(Actor)
    an_actor.should be_new_record
  end

  it "should not create an Actor when given no Event" do
    an_actor = nil ; expect { an_actor = Actor.create(@no_event_params)
        }.to change { Actor.count }.by(0)
    an_actor.should be_kind_of(Actor)
    an_actor.should be_new_record
  end

end
