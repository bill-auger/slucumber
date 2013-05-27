require 'spec_helper'

def create_expect_change(clients_params , change)
  clients = []
  expect { clients_params.each { | params | clients << Client.create(params) }
  }.to change { Client.count }.by(change) ;
  clients
end


describe Client do
  before do
    @a_password = @a_password_confirmation = "letmein" ; @a_lm = "a_lm" ; @some_notes = "notes" ;
    @minimal_params = { :nick => "Fred Flintstone" , :password => @a_password , :password_confirmation => @a_password_confirmation }
    @no_nick_params = { :password => @a_password , :password_confirmation => @a_password_confirmation }
    @no_pass_params = { :nick => "Fred Flintstone" }
    @no_conf_params = { :nick => "Fred Flintstone" , :password => @a_password }
    @full_params =    { :nick => "Fred Flintstone" , :password => @a_password , :password_confirmation => @a_password_confirmation , :landmark => @a_lm , :notes => @some_notes }
  end

  describe "validations" do
    it "should create a Client when given minimal params" do
      a_client = create_expect_change([@minimal_params] , 1).first
      a_client.should be_kind_of(Client)
      a_client.should be_persisted
    end

    it "should not create a Client when given no nick" do
      a_client = create_expect_change([@no_nick_params] , 0).first
      a_client.should be_kind_of(Client)
      a_client.should be_new_record
    end

    it "should not create a Client when given a duplicate nick (case sensitive)" do
      clients = create_expect_change([@minimal_params , @minimal_params] , 1)
      a_client = clients[0] ; another_client = clients[1] ;
      a_client.should be_kind_of(Client)
      another_client.should be_kind_of(Client)
      a_client.should be_persisted
      another_client.should be_new_record
    end

    it "should not create a Client when given a duplicate nick (case insensitive)" do
      upcased_params = @minimal_params.merge(:nick => @minimal_params[:nick].upcase)
      downcased_params = @minimal_params.merge(:nick => @minimal_params[:nick].downcase)
      clients = create_expect_change([upcased_params , downcased_params] , 1)
      a_client = clients[0] ; another_client = clients[1] ;
      a_client.should be_kind_of(Client)
      another_client.should be_kind_of(Client)
      a_client.should be_persisted
      another_client.should be_new_record
    end

    it "should not create a Client when given no password" do
      a_client = create_expect_change([@no_pass_params] , 0).first
      a_client.should be_kind_of(Client)
      a_client.should be_new_record
    end

    it "should not create a Client when given no password confirmation" do
#      pending "Client with a no password confirmation should not be valid but it is"
      a_client = create_expect_change([@no_conf_params] , 0).first
      a_client.should be_kind_of(Client)
      a_client.should be_new_record
    end

    it "should not create a Client when given a short password" do
      pass = (Devise.password_length.min - 1).times.collect { "x" }.join
      params = @no_pass_params.merge(:password => pass , :password_confirmation => pass)
      Client.new(params).should_not be_valid
    end

    it "should not create a Client when given a long password" do
      pass = (Devise.password_length.max + 1).times.collect { "x" }.join
      params = @no_pass_params.merge(:password => pass , :password_confirmation => pass)
      Client.new(params).should_not be_valid
    end
  end

  describe "attributes" do
    describe "with minimal params" do
      before do
        @a_client = Client.create(@minimal_params)
      end

      it "should set the nick attribute" do
        @a_client.should respond_to(:nick)
        @a_client.password.should == @a_password
      end

      it "should set the password attribute" do
        @a_client.should respond_to(:password)
        @a_client.password.should == @a_password
      end

      it "should set the password_confirmation attribute" do
        @a_client.should respond_to(:password_confirmation)
        @a_client.password_confirmation.should == @a_password_confirmation
      end

      it "should set the landmark attribute to the empty string" do
        @a_client.should respond_to(:landmark)
        @a_client.landmark.should == ""
      end

      it "should set the notes attribute to the empty string" do
        @a_client.should respond_to(:notes)
        @a_client.notes.should == ""
      end

      it "should set the internal email attribute" do
        @a_client.should respond_to(:email)
        @a_client.email.should == @a_client.nick + BOGUS_EMAIL
      end

      it "should set the internal encrypted_password attribute" do
        @a_client.should respond_to(:encrypted_password)
        @a_client.encrypted_password.should_not be_blank
      end

      it "(db) should set the internal is_admin false" do
        @a_client.should respond_to(:is_admin)
        @a_client.is_admin.should be(false)
      end
    end

    describe "with full params" do
      before do
        @a_client = Client.create(@full_params)
      end

      it "should create a Client when given full params" do
        @a_client.should be_kind_of(Client)
        @a_client.should be_persisted
      end

      it "should set the landmark attribute" do
        @a_client.should respond_to(:landmark)
        @a_client.landmark.should == @a_lm
      end

      it "should set the notes attribute" do
        @a_client.should respond_to(:notes)
        @a_client.notes.should == @some_notes
      end
    end

  end

  describe "associations" do
    before do
      @a_client = Client.create(@minimal_params)
    end

    it "should be associated with projects" do
      @a_client.should respond_to(:projects)
      @a_client.projects.size.should be(0)
      @a_client.is_admin.should be(false)
    end
  end
end
