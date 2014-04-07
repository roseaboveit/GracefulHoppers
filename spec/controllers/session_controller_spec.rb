require 'spec_helper'

describe SessionController do

  before do 
    request.env["devise.mapping"] = Devise.mappings[:user] 
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] 
  end

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do

    it "successfully creates a session" do
      expect(session[:user_id]).to be_nil
      post :create, provider: :twitter
      expect(session[:user_id]).to_not be_nil
    end

    it "redirects user"

  end

  describe "DELETE destroy" do

    it "should change the session's user_id to nil" do
      delete :destroy
      expect(session[:user_id]).to be_nil
    end 

    it "should redirect the user to the homepage" do
      delete :destroy
      expect(response).to redirect_to root_path
    end
  end
end
