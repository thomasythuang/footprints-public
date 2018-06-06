require 'spec_helper'
require 'spec_helpers/craftsman_factory'

describe CraftsmenController do
  let(:repo) { Footprints::Repository }
  let(:test_date) { (Date.today + 2) }

  let(:user) { double('user') }

  before :each do
    # remove when controller macro signs in user
    allow(controller).to receive(:current_user) { user }
  end

  context "no authentication" do
    context "GET profile" do
      # this isn't signing in the user
      login_user

      it "assigns current_user" do
        get :profile
        expect(assigns(:user)).to eq(user)
      end
    end

    context "PUT update" do
      let(:current_user) { double('user') }

      before :each do
        allow(current_user).to receive(:update!)
        allow(controller).to receive(:current_user) { current_user }
      end

      it "updates user record" do
        description = 'Fight me!'
        params = { user: { description: description } }

        expect(current_user).to receive(:update!).with('description' => description)

        put :update, params
      end
    end

    context "GET seeking" do
      it "assigns craftsmen seeking residents" do
        allow_any_instance_of(CraftsmenPresenter).to receive(:seeking_resident_apprentice).and_return(["a", "b"])
        get :seeking

        expect(assigns(:craftsmen_seeking_residents)).to eq(["a", "b"])
      end

      it "assigns craftsmen seeking students" do
        allow_any_instance_of(CraftsmenPresenter).to receive(:seeking_student_apprentice).and_return(["a", "b"])
        get :seeking

        expect(assigns(:craftsmen_seeking_students)).to eq(["a", "b"])
      end
    end
  end
end
