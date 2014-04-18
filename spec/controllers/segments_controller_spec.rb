require 'spec_helper'

describe SegmentsController do

  let(:segment) { create(:segment) }
  let(:user)    { create(:user) }

  context "Admin" do

    before do
      session[:user_id] = user.id
      User.any_instance.should_receive(:admin?).and_return(true)
    end

    describe "GET new" do
      it "renders the new page" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      context "with valid attributes" do
        it "saves the segment to the database" do
          expect { post :create, segment: attributes_for(:segment) }.to change(Segment, :count).by(1) 
        end

        it "redirects to the associated lesson edit page" do
          post :create, segment: attributes_for(:segment)
          expect(response).to redirect_to edit_lesson_path(segment.lesson_id.to_i)
        end
      end

      context "with invalid attributes" do
        it "does not save the segment to the database" do
          expect {post :create, segment: attributes_for(:segment, content_type: "fish")}.to change(Segment, :count).by(0)
        end

        it "redirects to the new segment page" do
          post :create, segment: attributes_for(:segment, content_type: "fish")
          expect(response).to redirect_to new_segment_path
        end
      end
    end

    describe "GET edit" do
      it "locates the correct segment" do
        get :edit, id: segment.id
        expect(assigns(:segment).id).to eq(segment.id)
      end

      it "renders the edit page" do
        get :edit, id: segment.id
        expect(response).to render_template :edit
      end
    end

    describe "PATCH update" do
      it "locates the correct segment" do
        patch :update, id: segment.id, segment: attributes_for(:segment)
        expect(assigns(:segment).id).to eq(segment.id)
      end

      context "with valid attributes" do
        it "updates the segment" do
          patch :update, id: segment.id, segment: attributes_for(:segment, content: "Updated Content")
          segment.reload
          expect(segment.content).to eq("Updated Content")
        end

        it "redirects to the associated edit lesson page" do
          patch :update, id: segment.id, segment: attributes_for(:segment, content: "Updated Content")
          segment.reload
          expect(response).to redirect_to edit_lesson_path(segment.lesson_id.to_i)
        end
      end

      context "with invalid attributes" do
        it "does not update the segment" do
          patch :update, id: segment.id, segment: attributes_for(:segment, content_type: "Bad Type")
          segment.reload
          expect(segment.content_type).to_not eq("Updated Content")
        end

        it "redirects to the edit segment page" do
          patch :update, id: segment.id, segment: attributes_for(:segment, content_type: "Bad Type")
          segment.reload
          expect(response).to redirect_to edit_segment_path(segment.id)
        end
      end
    end

    describe "DELETE destroy" do
      
    end

    describe "GET show" do
      # This should render a partial?
    end
  end
end
