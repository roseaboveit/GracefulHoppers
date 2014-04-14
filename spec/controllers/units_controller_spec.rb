require 'spec_helper'

describe UnitsController do

  let(:unit) { create(:unit) }
  let(:user) { create(:user) }

  def make_current_user_admin
    User.any_instance.should_receive(:admin?).and_return(true)
  end

  context "Admin user" do
    before do
      session[:user_id] = user.id
      make_current_user_admin
    end

    describe "GET new" do
      it "renders the new unit template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      context "with valid attributes" do
        it "creates a new unit" do
          expect { post :create, unit: attributes_for(:unit) }.to change(Unit, :count).by(1)
        end

        it "renders the unit show page" do
          post :create, unit: attributes_for(:unit)
          expect(response).to redirect_to unit_path(assigns(:unit).id)
        end
      end

      context "with invalid attributes" do
        it "does not create a new unit" do
          expect { post :create, unit: attributes_for(:unit, description: nil) }.to_not change(Unit, :count).by(1)
        end

        it "renders the unit new page" do
          post :create, unit: attributes_for(:unit, description: nil)
          expect(response).to redirect_to new_unit_path
        end
      end
    end

    describe "GET show" do
      it "locates the correct unit" do
        get :show, id: unit.id
        expect(assigns(:unit).id).to eq(unit.id)
      end

      it "renders the unit show page" do
        get :show, id: unit.id
        expect(response).to render_template :show
      end
    end

    describe "GET index" do
      it "displays the index page" do
        get :index
        expect(response).to render_template :index
      end

      it "populates an array with all the units" do
        get :index
        expect(assigns(:units)).to eq([unit])
      end
    end

    describe "GET edit" do
      it "locates the right unit" do
        get :edit, id: unit.id
        expect(assigns(:unit).id).to eq(unit.id)
      end

      it "displays the unit edit page" do
        get :edit, id: unit.id
        expect(response).to render_template :edit
      end
    end

    describe "PATCH update" do
      it "locates the correct unit" do
        patch :update, id: unit.id, unit: attributes_for(:unit, published: true)
        expect(assigns(:unit).id).to eq(unit.id)
      end

      context "valid attributes" do
        it "updates the unit in database" do
          patch :update, id: unit.id, unit: attributes_for(:unit, published: true)
          unit.reload
          expect(unit.published).to be_true
        end

        it "redirects the user to the unit show page" do
          patch :update, id: unit.id, unit: attributes_for(:unit, published: true)
          unit.reload
          expect(response).to redirect_to unit
        end
      end

      context "invalid attributes" do
        it "does not update the unit" do
          patch :update, id: unit.id, unit: attributes_for(:unit, total_points: "n")
          unit.reload
          expect(unit.total_points).to_not eq("n")
        end

        it "renders the unit edit page" do
          patch :update, id: unit.id, unit: attributes_for(:unit, total_points: "n")
          unit.reload
          expect(response).to redirect_to edit_unit_path(unit)
        end
      end
    end
  end
    
  context "Student user" do
    describe "GET show" do
      context "unpublished unit" do
        it "redirects user to homepage"
        it "displays a notice that this content is not currently available"
      end

      context "published unit ahead of student's current unit" do
        it "redirects user to the unit they are currently on"
        it "displays a notice that perhaps this unit would be better"
      end

      context "published unit >= student's current unit" do
        it "renders the unit show page"
      end
    end

    describe "GET index" do
      it "redirects user to their unit history page"
    end
    
    describe "GET edit" do
      it "redirects user to the unit they are currently on"
      it "displays a notice that perhaps this unit would be better"
    end
  end

  context "Non-member user" do
    describe "GET show" do
      it "redirects user to the homepage"
      it "displays a notice that the content was unauthorized without an account"
    end

    describe "GET index" do
      it "redirects user to the homepage"
      it "displays notice that user is unauthorized to view content"
    end

    describe "GET edit" do
      it "redirects user to the homepage"
      it "displays notice that user is unauthorized to view content"
    end
  end
end
