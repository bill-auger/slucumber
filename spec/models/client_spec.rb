require 'spec_helper'

describe Client do
  before do
    @a_nick = "A Nick" ; @a_lm = "a_lm" ;
    @an_email = "an@email.address" ; @some_notes = "notes" ;
    @only_nick_params = { :nick => @a_nick }
    @no_nick_params = { :lm => @a_lm , :email => @an_email , :notes => @some_notes }
    @full_params = { :nick => @a_nick , :lm => @a_lm , :email => @an_email , :notes => @some_notes }
  end

  it "should create a Client when given only a nick" do
    a_client = Client.create(@only_nick_params)
    a_client.should be_kind_of(Client)
    a_client.nick.should == @a_nick
    a_client.lm.should == ""
    a_client.email.should == ""
    a_client.notes.should == ""
  end

  it "should not create a Client when given no nick" do
    a_client = nil
    expect { a_client = Client.create(@no_nick_params) }.to change { Client.count }.by(0)
    a_client.should be_kind_of(Client)
    a_client.should be_new_record
  end

  it "should create a Client with all fields set when given full params" do
    a_client = Client.create(@full_params)
    a_client.should be_kind_of(Client)
    a_client.nick.should == @a_nick
    a_client.lm.should == @a_lm
    a_client.email.should == @an_email
    a_client.notes.should == @some_notes
  end
end
