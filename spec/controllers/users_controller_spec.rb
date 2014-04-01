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
        expect(response).to redirect_to user_path(assigns(:user).id)
      end
    end

    context "with invalid attributes" do
      it "does not save the user to the database" do
        expect { post :create, user: attributes_for(:user, username: nil) }.to_not change(User, :count).by(1)
      end

      it "re-renders the new page" do
        post :create, user: attributes_for(:user, username: nil)
        expect(response).to redirect_to new_user_path
      end

      it "displays an error message for the user" do
        post :create, user: attributes_for(:user, username: nil)
        expect(flash[:notice]).to_not be_blank
      end
    end
  end

  describe "GET edit" do
    it "locates the requested User" do
      get :edit, id: @user.id
      expect(assigns(:user).id).to eq(@user.id)
    end

    it "renders the edit page" do
      get :edit, id: @user.id
      expect(response).to render_template :edit
    end
  end

  describe "PATCH update" do
    context "with valid attributes" do
      it "locates the correct user" do
        patch :update, id: @user.id, user: attributes_for(:user)
        expect(assigns(:user).id).to eq(@user.id)
      end

      it "updates the user to the database" do
        patch :update, id: @user.id, user: attributes_for(:user, name: "Married Name")
        @user.reload
        expect(@user.name).to eq("Married Name")
      end

      it "redirects the user to the user's show pages" do
        patch :update, id: @user.id, user: attributes_for(:user, name: "Married Name")
        expect(response).to redirect_to @user
      end
    end

    context "with invalid attributes" do
      it "displays an error message for the user" do
        patch :update, id: @user.id, user: attributes_for(:user, name: nil)
        expect(flash[:notice]).to_not be_blank
      end

      it "does not update the user in the database" do
        patch :update, id: @user.id, user: attributes_for(:user, name: nil)
        @user.reload
        expect(@user.name).to_not be_nil
      end

      it "re-renders the edit page" do
        patch :update, id: @user.id, user: attributes_for(:user, name: nil)
        expect(response).to redirect_to edit_user_path(@user.id)
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
