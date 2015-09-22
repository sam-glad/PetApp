require 'rails_helper'

RSpec.describe ApplicationFormsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # ApplicationForm. As you add validations to ApplicationForm, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
      { name: 'My First Application Form' }
    }

  let(:invalid_attributes) {
      { name: nil }
    }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ApplicationFormsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all application_forms as @application_forms" do
      application_form = ApplicationForm.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:application_forms)).to eq([application_form])
    end
  end

  describe "GET show" do
    it "assigns the requested application_form as @application_form" do
      application_form = ApplicationForm.create! valid_attributes
      get :show, {:id => application_form.to_param}, valid_session
      expect(assigns(:application_form)).to eq(application_form)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ApplicationForm" do
        expect {
          post :create, {:application_form => valid_attributes}, valid_session
        }.to change(ApplicationForm, :count).by(1)
      end

      it "assigns a newly created application_form as @application_form" do
        post :create, {:application_form => valid_attributes}, valid_session
        expect(assigns(:application_form)).to be_a(ApplicationForm)
        expect(assigns(:application_form)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved application_form as @application_form" do
        post :create, {:application_form => invalid_attributes}, valid_session
        expect(assigns(:application_form)).to be_a_new(ApplicationForm)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
          { name: 'My Second Application Form' }
        }

      it "updates the requested application_form" do
        application_form = ApplicationForm.create! valid_attributes
        put :update, {:id => application_form.to_param, :application_form => new_attributes}, valid_session
        application_form.reload
        new_attributes.each_pair do |key, value|
          expect(application_form[key]).to eq(value)
        end
      end

      it "assigns the requested application_form as @application_form" do
        application_form = ApplicationForm.create! valid_attributes
        put :update, {:id => application_form.to_param, :application_form => valid_attributes}, valid_session
        expect(assigns(:application_form)).to eq(application_form)
      end
    end

    describe "with invalid params" do
      it "assigns the application_form as @application_form" do
        application_form = ApplicationForm.create! valid_attributes
        put :update, {:id => application_form.to_param, :application_form => invalid_attributes}, valid_session
        expect(assigns(:application_form)).to eq(application_form)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested application_form" do
      application_form = ApplicationForm.create! valid_attributes
      expect {
        delete :destroy, {:id => application_form.to_param}, valid_session
      }.to change(ApplicationForm, :count).by(-1)
    end
  end

end
