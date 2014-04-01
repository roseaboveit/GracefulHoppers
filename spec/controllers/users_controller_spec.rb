require 'spec_helper'

describe UsersController do
  before :each do
      @user = create(:user) 
  end


  describe "GET new" do
    it "displays the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "saves the user to the database" do
        expect { post :create, user: attributes_for(:user) }.to change(User, :count).by(1)
      end

      it "redirects the user" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to @user
      end
    end

    context "with invalid attributes" do
      it "does not save the user to the database" do
        expect { post :create, user: attributes_for(:user, username: nil) }.to_not change(User, :count).by(1)
      end

      it "re-renders the new page" do
        post :create, user: attributes_for(:user, username: nil)
        expect(response).to redirect_to new_list_path
      end

      it "displays an error message for the user" do
        post :create, user: attributes_for(:user, username: nil)
        expect(flash[:notice]).to_not be_blank
      end
    end
  end

  describe "GET edit" do
    it "locates the requested User" do
      
    end

    it "renders the edit page" do
      
    end
  end

  describe "PATCH update" do
    context "with valid attributes" do
      it "locates the correct user" do
        
      end

      it "updates the user to the database" do
        
      end

      it "redirects the user to the user's show pages" do
        
      end
    end

    context "with invalid attributes" do
      it "displays an error message for the user" do
        
      end

      it "does not update the user in the database" do
        
      end

      it "re-renders the edit page" do
        
      end
    end
  end

  describe "GET show" do
    it "locates the requested User" do
      
    end

    it "renders the show page" do
      
    end
  end

  describe "GET index" do
    it "locates the users and populates a user array" do
      
    end

    it "renders the index page" do
      
    end
  end
end
