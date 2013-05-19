require 'spec_helper'

describe Client do
  before do
    @an_email = "an@email.address" ; @a_password = @a_password_confirmation = "letmein" ;
    @a_lm = "a_lm" ; @some_notes = "notes" ;
    @minimal_params = { :email => @an_email , :password => @a_password , :password_confirmation => @a_password_confirmation }
    @no_email_params = { :password => @a_password , :password_confirmation => @a_password_confirmation }
    @no_pass_params = { :email => @an_email }
    @full_params = { :email => @an_email , :password => @a_password , :password_confirmation => @a_password_confirmation , :lm => @a_lm , :notes => @some_notes }
  end

  it "should create a Client when given minimal params" do
    a_client = nil ; expect { a_client = Client.create(@minimal_params)
        }.to change { Client.count }.by(1) ;
    a_client.should be_kind_of(Client)
    a_client.email.should == @an_email
    a_client.password.should == @a_password
    a_client.password_confirmation.should == @a_password_confirmation
    a_client.lm.should == ""
    a_client.notes.should == ""
  end

  it "should not create a Client when given no email" do
    a_client = nil ; expect { a_client = Client.create(@no_email_params)
        }.to change { Client.count }.by(0) ;
    a_client.should be_kind_of(Client)
    a_client.should be_new_record
  end

  it "should not create a Client when given no password" do
    a_client = nil ; expect { a_client = Client.create(@no_pass_params)
        }.to change { Client.count }.by(0) ;
    a_client.should be_kind_of(Client)
    a_client.should be_new_record
  end

  it "should create a Client with all fields set when given full params" do
    a_client = Client.create(@full_params)
    a_client.should be_kind_of(Client)
    a_client.email.should == @an_email
    a_client.password.should == @a_password
    a_client.password_confirmation.should == @a_password_confirmation
    a_client.lm.should == @a_lm
    a_client.notes.should == @some_notes
  end
end
