require 'spec_helper'

describe UsersController do

  let(:user) { create(:user) }

  describe "GET edit" do
    before do
      session[:user_id] = user.id
    end

    it "locates the requested User" do
      get :edit, id: user.id
      expect(assigns(:user).id).to eq(user.id)
    end

    it "renders the edit page" do
      get :edit, id: user.id
      expect(response).to render_template :edit
    end
  end

  describe "PATCH update" do
    context "with valid attributes" do
      it "locates the correct user" do
        patch :update, id: user.id, user: attributes_for(:user)
        expect(assigns(:user).id).to eq(user.id)
      end

      it "updates the user to the database" do
        patch :update, id: user.id, user: attributes_for(:user, name: "Married Name")
        user.reload
        expect(user.name).to eq("Married Name")
      end

      it "redirects the user to the user's show pages" do
        patch :update, id: user.id, user: attributes_for(:user, name: "Married Name")
        expect(response).to redirect_to user
      end
    end

    context "with invalid attributes" do
      it "displays an error message for the user" do
        patch :update, id: user.id, user: attributes_for(:user, name: nil)
        expect(flash[:notice]).to_not be_blank
      end

      it "does not update the user in the database" do
        patch :update, id: user.id, user: attributes_for(:user, name: nil)
        user.reload
        expect(user.name).to_not be_nil
      end

      it "re-renders the edit page" do
        patch :update, id: user.id, user: attributes_for(:user, name: nil)
        expect(response).to redirect_to edit_user_path(user.id)
      end
    end
  end

  describe "GET show" do
    it "locates the requested User" do
      get :show, id: user.id
      expect(assigns(:user).id).to eq(user.id)
    end

    it "renders the show page" do
      get :show, id: user.id
      expect(response).to render_template :show
    end
  end

  describe "GET index" do
    before do
      session[:user_id] = user.id
    end

    it "locates the users and populates a user array" do
      User.any_instance.should_receive(:admin?).and_return(true)
      get :index
      expect(assigns(:users)).to eq([user])
    end

    it "renders the index page" do
      User.any_instance.should_receive(:admin?).and_return(true)
      get :index
      expect(response).to render_template :index
    end
  end

  describe "DELETE destroy" do
    before :each do
      @user = create(:user) 
    end

    it "locates the requested User" do
      delete :destroy, id: @user.id
      expect(assigns(:user).id).to eq(@user.id)
    end

    it "redirects to root_path" do
      delete :destroy, id: @user.id
      expect(response).to redirect_to root_path
    end

    it "decreases the user count by 1" do
      expect{delete :destroy, id: @user.id}.to change(User, :count).by(-1)
    end

    it "displays a flash message notifying of successful deletion" do
      delete :destroy, id: @user.id
      expect(flash[:notice]).to_not be_blank
    end
  end

  describe "GET admin" do
    before do
      session[:user_id] = user.id
    end
    
    it "accesses the admin dashboard if current user is an admin" do
      User.any_instance.should_receive(:admin?).and_return(true)

      get :admin, id: user.id
      
      expect(response).to render_template :admin
    end

    it "redirects to the root page if user is not an admin and displays a warning" do
      get :admin, id: user.id
      
      expect(response).to redirect_to root_path
      expect(flash[:notice]).to_not be_blank
    end
  end
end
