require 'spec_helper'

describe Actor do
  before do
    @an_event = FactoryGirl.create(:event)
    @no_kind_params = { :type => "Trigger" , :event_id => @an_event.id }
    @no_type_params = { :kind => USER_KIND , :event_id => @an_event.id }
    @no_event_params = { :kind => USER_KIND , :type => "Trigger" }
    @full_params = { :kind => USER_KIND , :type => "Trigger" , :event_id => @an_event.id }
  end

  it "should create an Actor when given full params" do
    an_actor = nil ; expect { an_actor = Actor.create(@full_params)
        }.to change { Actor.count }.by(1)
    an_actor.should be_kind_of(Actor)
    an_actor.should be_persisted
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
