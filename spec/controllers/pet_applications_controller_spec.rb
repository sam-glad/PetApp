require 'rails_helper'

RSpec.describe PetApplicationsController, type: :controller do

  def valid_attributes
    user = FactoryGirl.create(:user)
    pet = FactoryGirl.create(:pet)

    attributes = {
      application_type: 0, # TODO: Replace this with working enum
      pet_id: pet.id,
      pet: pet,
      organization: pet.organization,
      user: user,
    }

    return attributes.merge(questions_attributes: [FactoryGirl.attributes_for(:question)])
  end

  def invalid_attributes
    user = FactoryGirl.create(:user)
    pet = FactoryGirl.create(:pet)

    attributes = {
      application_type: 0, # TODO: Replace this with working enum
      pet_id: pet.id,
      pet: pet,
      organization: pet.organization,
      user: user,
    }

    return attributes.merge(questions_attributes: [FactoryGirl.attributes_for(:question)])
  end

  def new_attributes
    attributes = {
      application_type: 1 # TODO: Replace this with working enum
    }
  end

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user1 = FactoryGirl.create(:user)
    sign_in user1
    pet = FactoryGirl.create(:pet)
  end

  def valid_session
    {"warden.user.user.key" => session["warden.user.user.key"]}
  end

  it "should have a current_user" do
    subject.current_user.should_not be_nil
  end

  describe "GET #index" do
    it "assigns an organization's pet_applications as @pet_applications" do
      pet_application = PetApplication.create! valid_attributes
      get :index, {organization_id: 11}
      expect(assigns(:pet_applications)).to eq([pet_application])
    end
  end

  describe "GET #show" do
    it "assigns the requested pet_application as @pet_application" do
      pet_application = PetApplication.create! valid_attributes
      get :show, {:id => pet_application.to_param}
      expect(assigns(:pet_application)).to eq(pet_application)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PetApplication" do
        expect {
          post :create, {pet_application: valid_attributes}, valid_session
        }.to change(PetApplication, :count).by(1)
      end

      it "assigns a newly created pet_application as @pet_application" do
        post :create, {:pet_application => valid_attributes}
        expect(assigns(:pet_application)).to be_a(PetApplication)
        expect(assigns(:pet_application)).to be_persisted
      end
    end

    # context "with invalid params" do
    #   it "assigns a newly created but unsaved pet_application as @pet_application" do
    #     post :create, {:pet_application => invalid_attributes}
    #     expect(assigns(:pet_application)).to be_a_new(PetApplication)
    #   end
    # end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested pet_application" do
        pet_application = PetApplication.create! valid_attributes
        put :update, {:id => pet_application.to_param, :pet_application => new_attributes}
        pet_application.reload
        new_attributes.each_pair do |key, value|
          expect(pet_application[key]).to eq(value)
        end
      end

      it "assigns the requested pet_application as @pet_application" do
        pet_application = PetApplication.create! valid_attributes
        put :update, {:id => pet_application.to_param, :pet_application => valid_attributes}
        expect(assigns(:pet_application)).to eq(pet_application)
      end
    end

    context "with invalid params" do
      it "assigns the pet_application as @pet_application" do
        pet_application = PetApplication.create! valid_attributes
        put :update, {:id => pet_application.to_param, :pet_application => invalid_attributes}
        expect(assigns(:pet_application)).to eq(pet_application)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested pet_application" do
      pet_application = PetApplication.create! valid_attributes
      expect {
        delete :destroy, {:id => pet_application.to_param}
      }.to change(PetApplication, :count).by(-1)
    end
  end
end
