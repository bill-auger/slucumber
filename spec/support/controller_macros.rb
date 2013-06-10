module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:client]
      sign_in FactoryGirl.create(:admin)
    end
  end

  def login_client
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:client]
      sign_in FactoryGirl.create(:client)
    end
  end
end