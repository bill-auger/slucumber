require 'spec_helper'

describe ProjectsController do

  login_client
  let(:valid_attributes) { { :name => "Project Name" , :client_id => subject.current_client.id } }

  describe "valid session" do
    it "should have a current_client" do
      subject.current_client.should_not be_nil
    end
  end

  describe "GET index" do
    it "assigns all projects as @projects" do
      project = Project.create! valid_attributes
      get :index , {}
      assigns(:projects).should eq([project])
      response.should be_success
    end
  end

  describe "GET show" do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :show , { :id => project.to_param }
      assigns(:project).should eq(project)
      response.should be_success
    end
  end

  describe "GET new" do
    it "assigns a new project as @project" do
      get :new , {}
      assigns(:project).should be_a_new(Project)
      response.should be_success
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :edit , { :id => project.to_param }
      assigns(:project).should eq(project)
      response.should be_success
    end
  end

  describe "POST create" do
    describe "when 'Cancel' button pressed" do
      it "redirects to the projects page" do
        post :create , { :commit => "Cancel" , :project => valid_attributes }
        response.should redirect_to projects_path
      end
    end

    describe "when duplicate project name exists" do
      it "re-renders the new project form" do
        project = Project.create! valid_attributes
        post :create , { :project => valid_attributes }
        response.should render_template :new
      end
    end

    describe "with valid params" do
      it "creates a new Project" do
        expect { post :create , { :project => valid_attributes }
            }.to change(Project, :count).by(1)
      end

      it "assigns a newly created project as @project" do
        post :create , { :project => valid_attributes }
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end

      it "redirects to the created project edit page" do
        post :create , { :project => valid_attributes }
        response.should redirect_to edit_project_path(Project.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        Project.any_instance.stub(:save).and_return(false)
        post :create , { :project => {  } }
        assigns(:project).should be_a_new(Project)
      end

      it "re-renders the 'new' template" do
        Project.any_instance.stub(:save).and_return(false)
        post :create , { :project => {  } }
        response.should render_template(:new)
      end
    end
  end

  describe "PUT update" do
    before do
      @project = Project.create! valid_attributes
    end

    describe "when 'Cancel' button pressed" do
      it "redirects to the projects page" do
        put :update , { :commit => "Cancel" , :id => @project.to_param , :project => {} }
        response.should redirect_to projects_path
      end
    end

    describe "with valid params" do
      it "updates the requested project" do
        Project.any_instance.should_receive(:update_attributes).with({ "these" => "params" })
        put :update , { :id => @project.to_param , :project => { "these" => "params" } }
      end

      it "assigns the requested project as @project" do
        put :update , { :id => @project.to_param , :project => valid_attributes }
        assigns(:project).should eq(@project)
      end

      it "redirects to the project" do
        put :update , { :id => @project.to_param , :project => valid_attributes }
        response.should redirect_to(@project)
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        Project.any_instance.stub(:save).and_return(false)
        put :update , { :id => @project.to_param , :project => {} }
        assigns(:project).should eq(@project)
      end

      it "re-renders the 'edit' template" do
        Project.any_instance.stub(:save).and_return(false)
        put :update , { :id => @project.to_param , :project => {} }
        response.should render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @project = Project.create! valid_attributes
    end

    it "destroys the requested project" do
      expect { delete :destroy, { :id => @project.to_param }
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      delete :destroy, { :id => @project.to_param }
      response.should redirect_to(projects_url)
    end
  end

end
