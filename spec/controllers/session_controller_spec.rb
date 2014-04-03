require 'spec_helper'

describe SessionController do
  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    #This is the one that will need a twitter oauth mock object
    
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
