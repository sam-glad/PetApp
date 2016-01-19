require 'rails_helper'

RSpec.describe PetApplicationsController, type: :controller do

  def valid_attributes(user = nil)
    user ||= FactoryGirl.create(:user)
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
      status: 2 # TODO: Replace this with working enum
    }
  end

  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login(user)
  end

  describe "GET #index" do
    it "assigns an organization's pet_applications as @pet_applications" do
      pet_application = PetApplication.create! valid_attributes
      get :index, {organization_id: pet_application.pet.organization_id}
      expect(assigns(:pet_applications)).to eq([pet_application])
    end
  end

  describe "GET #show" do
    it "assigns the requested pet_application as @pet_application" do
      pet_application = PetApplication.create! valid_attributes
      get :show, {:id => pet_application.to_param}
      expect(assigns(:pet_application)).to eq(pet_application)
    end

    context 'with an unauthorized user' do
      it 'fails to show the requested pet_application' do
        pet_application = PetApplication.create! valid_attributes
        get :show, {:id => pet_application.to_param}
        expect(response).to have_http_status(403)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new PetApplication" do
        expect {
          post :create, {pet_application: valid_attributes}
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
    context 'with an authorized user' do
      context "with valid params" do
        it "updates the requested pet_application" do
          pet_application = PetApplication.create! valid_attributes(user)
          put :update, {:id => pet_application.to_param, :pet_application => new_attributes}
          pet_application.reload
          new_attributes.each_pair do |key, value|
            expect(pet_application[key]).to eq(value)
          end
        end

        it "assigns the requested pet_application as @pet_application" do
          pet_application = PetApplication.create! valid_attributes(user)
          put :update, {:id => pet_application.to_param, :pet_application => valid_attributes}
          expect(assigns(:pet_application)).to eq(pet_application)
        end
      end

      context "with invalid params" do
        it "assigns the pet_application as @pet_application" do
          pet_application = PetApplication.create! valid_attributes(user)
          put :update, {:id => pet_application.to_param, :pet_application => invalid_attributes}
          expect(assigns(:pet_application)).to eq(pet_application)
        end
      end
    end

    context 'with an unauthorized user' do
      it 'returns 403 Forbidden' do
        pet_application = PetApplication.create! valid_attributes
        put :update, {:id => pet_application.to_param, :pet_application => new_attributes}
        expect(response).to have_http_status(403)
      end

      it 'fails to update the requested pet_application' do
        pet_application = PetApplication.create! valid_attributes
        put :update, {:id => pet_application.to_param, :pet_application => new_attributes}
        pet_application_after_update = pet_application.reload
        expect(pet_application_after_update).to eq(pet_application)
      end
    end
  end

  describe "DELETE #destroy" do
    context 'with an authorized user' do
      it "destroys the requested pet_application" do
        pet_application = PetApplication.create! valid_attributes(user)
        expect {
          delete :destroy, {:id => pet_application.to_param}
        }.to change(PetApplication, :count).by(-1)
      end
    end

    context 'with an unauthorized user' do
      it 'returns 403 Forbidden' do
        pet_application = PetApplication.create! valid_attributes
        delete :destroy, {:id => pet_application.to_param}
        expect(response).to have_http_status(403)
      end

      it 'fails to destroy the requested pet_application' do
        pet_application = PetApplication.create! valid_attributes
        expect {
          delete :destroy, {:id => pet_application.to_param}
        }.to change(PetApplication, :count).by(0)
      end
    end
  end
end
