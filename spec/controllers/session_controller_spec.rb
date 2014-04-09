require 'spec_helper'

describe SessionController do

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do

    before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }

    it "redirects to home page" do
      get :create, provider: :twitter
      expect(response).to be_redirect
    end

    it "creates a user" do
      expect { get :create, provider: :twitter }.to change(User, :count).by(1)
    end

    it "creates a session" do
      expect(session[:user_id]).to be_nil
      post :create, provider: :twitter
      expect(session[:user_id]).to_not be_nil
    end

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
