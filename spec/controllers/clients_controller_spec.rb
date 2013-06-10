require 'spec_helper'

describe ClientsController do

  login_admin
  let(:valid_attributes) { { :nick => "Fred Flintstone" , :password => "letmein" , :password_confirmation => "letmein" } }
  before { @a_client = Client.create(valid_attributes) }

  describe "valid session" do
    it "should have a current_client" do
      subject.current_client.should_not be_nil
    end
  end

  describe "GET index" do
    it "assigns all clients except the logged in admin as @clients" do
      get :index , {}
      assigns(:clients).should eq([@a_client])
      response.should be_success
    end
  end

  describe "GET edit" do
    it "assigns the requested client as @client" do
      get :edit , { :id => @a_client.id }
      assigns(:client).should eq(@a_client)
      response.should be_success
    end
  end

  describe "PUT update" do
    describe "when 'Back' button pressed" do
      it "redirects to the clients page" do
        put :update , { :commit => "Back" , :id => @a_client.id , :client => {} }
        response.should redirect_to clients_path
      end
    end

    describe "when 'Destroy Client' button pressed" do
      it "destroys the client and redirects to the clients page" do
        expect { put :update , { :commit => "Destroy Client" , :id => @a_client.id , :client => {} }
            }.to change { Client.count }.by -1
        response.should redirect_to clients_path
      end
    end

    describe "with valid params" do
      it "updates the requested client" do
        Client.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update , { :id => @a_client.id , :client=> { "these" => "params" } }
      end

      it "assigns the requested client as @client" do
        put :update , { :id => @a_client.id , :client => valid_attributes }
        assigns(:client).should eq(@a_client)
      end

      it "redirects to the client edit page" do
        put :update , { :id => @a_client.id , :client => valid_attributes }
        response.should redirect_to(edit_client_path(@a_client))
      end
    end

    describe "with invalid params" do
      it "assigns the client as @client" do
        Client.any_instance.stub(:save).and_return(false)
        put :update , { :id => @a_client.id , :client => {} }
        assigns(:client).should eq(@a_client)
      end

      it "re-renders the 'edit' template" do
        Client.any_instance.stub(:save).and_return(false)
        put :update , { :id => @a_client.id , :client => {} }
        response.should render_template(:edit)
      end
    end
  end

end
