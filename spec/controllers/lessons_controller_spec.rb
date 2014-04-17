require 'spec_helper'

describe LessonsController do

  let(:user) { create(:user) }
  let(:unit) { create(:unit) }
  let(:lesson) { create(:lesson) }

  context "Admin" do

    before do
      session[:user_id] = user.id
      User.any_instance.should_receive(:admin?).and_return(true)
    end

    describe "GET new" do
      it "renders new lesson template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      context "with valid attributes" do
        it "creates a new lesson" do
          expect { post :create, lesson: attributes_for(:lesson) }.to change(Lesson, :count).by(1)
        end

        it "renders the lesson show page" do
          post :create, lesson: attributes_for(:lesson)
          expect(response).to render_template :show
        end
      end

      context "with invalid attributes" do
        it "does not create a new lesson" do
          expect { post :create, lesson: attributes_for(:lesson, points: nil) }.to_not change(Lesson, :count).by(1)
        end

        it "directs user back to the new template" do
          post :create, lesson: attributes_for(:lesson, points: nil)
          expect(response).to redirect_to new_lesson_path
        end

        it "displays a flash notice" do
          post :create, lesson: attributes_for(:lesson, points: nil)
          expect(flash[:notice]).to_not be_blank
        end
      end
    end

    describe "GET edit" do
      it "locates the requested lesson" do
        get :edit, id: lesson.id
        expect(assigns(:lesson).id).to eq(lesson.id) 
      end

      it "renders edit lesson template" do
        get :edit, id: lesson.id
        expect(response).to render_template :edit
      end  
    end

    describe "PATCH update" do
      it "locates the requested lesson" do
        patch :update, id: lesson.id, lesson: attributes_for(:lesson, points: 12)
        expect(assigns(:lesson).id).to eq(lesson.id)
      end

      context "with valid attributes" do
        it "updates the lesson" do
          patch :update, id: lesson.id, lesson: attributes_for(:lesson, points: 12)
          lesson.reload
          expect(lesson.points).to eq(12)
        end

        it "directs user to the lesson show page" do
          patch :update, id: lesson.id, lesson: attributes_for(:lesson, points: 12)
          lesson.reload
          expect(response).to redirect_to lesson
        end
      end

      context "with invalid attributes" do
        it "does not update the lesson" do
          patch :update, id: lesson.id, lesson: attributes_for(:lesson, description: nil)
          lesson.reload
          expect(lesson.description).to_not be_nil
        end

        it "redirects user to the lesson edit page" do
          patch :update, id: lesson.id, lesson: attributes_for(:lesson, description: nil)
          lesson.reload
          expect(response).to redirect_to edit_lesson_path
        end
      end
    end

    describe "GET show" do
      it "locates the requested lesson" do
        get :show, id: lesson.id
        expect(assigns(:lesson).id).to eq(lesson.id)
      end

      it "renders the lesson show page" do
        get :show, id: lesson.id
        expect(response).to render_template :show
      end
    end
  end

  context "Student" do

    before do
      session[:user_id] = user.id
      User.any_instance.should_receive(:admin?).any_number_of_times.and_return(false)
    end

    describe "GET new" do
      it "redirects user to the homepage" do
        get :new
        expect(response).to redirect_to root_path
      end

      it "displays notice that user is unauthorized to view content" do
        get :new
        expect(flash[:notice]).to_not be_blank
      end
    end

    describe "GET edit" do
      it "redirects user to the homepage" do
        get :edit, id: lesson.id
        expect(response).to redirect_to root_path
      end

      it "displays notice that user is unauthorized to view content" do
        get :edit, id: lesson.id
        expect(flash[:notice]).to_not be_blank
      end
    end

    describe "GET show" do

      context "part of accessible unit" do
        before do
          User.any_instance.should_receive(:check_progress?).and_return(true)
          Lesson.any_instance.should_receive(:unit_published?).and_return(true)
        end

        it "renders the lesson show page" do
          get :show, id: lesson.id
          expect(response).to render_template :show
        end
      end

      context "part of unaccessible unit" do
        before do
          User.any_instance.should_receive(:check_progress?).and_return(false)
          Lesson.any_instance.should_receive(:unit_published?).and_return(true)
        end

        it "redirects to user's current unit show page" do
          get :show, id: lesson.id
          expect(response).to redirect_to unit_path(user.unit)
        end

        it "displays a notice not to skip ahead" do
          get :show, id: lesson.id
          expect(flash[:notice]).to_not be_blank
        end
      end

      context "part of unpublished unit" do
        before do
          User.any_instance.should_receive(:check_progress?).and_return(true)
          Lesson.any_instance.should_receive(:unit_published?).and_return(false)
        end

        it "redirects the user to the user's profile page" do
          get :show, id: lesson.id
          expect(response).to redirect_to user_path(user.id)
        end

        it "displays notice that user content is not yet available" do
          get :show, id: lesson.id
          expect(flash[:notice]).to_not be_blank
        end
      end
    end    
  end

  context "Visitor" do
    describe "GET new" do
      it "redirects user to the homepage" do
        get :new
        expect(response).to redirect_to root_path
      end

      it "displays notice that user is unauthorized to view content" do
        get :new
        expect(flash[:notice]).to_not be_blank
      end
    end

    describe "GET edit" do
      it "redirects user to the homepage" do
        get :edit, id: lesson.id
        expect(response).to redirect_to root_path
      end

      it "displays notice that user is unauthorized to view content" do
        get :edit, id: lesson.id
        expect(flash[:notice]).to_not be_blank
      end
    end

    describe "GET show" do
      it "redirects user to the homepage" do
        get :show, id: lesson.id
        expect(response).to redirect_to root_path
      end

      it "displays notice that user is unauthorized to view content" do
        get :show, id: lesson.id
        expect(flash[:notice]).to_not be_blank
      end
    end    
  end
end
