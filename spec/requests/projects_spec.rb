require 'spec_helper'

describe "Projects" do

  describe "not logged in GET /" do
    it "should redirect to /clients/sign_in" do
      get root_path
      response.status.should be(302)
      response.should redirect_to(new_client_session_path)
    end
  end

  describe "not logged in GET /projects" do
    it "should redirect to /clients/sign_in" do
      get projects_path
      response.status.should be(302)
      response.should redirect_to(new_client_session_path)
    end
  end

end
