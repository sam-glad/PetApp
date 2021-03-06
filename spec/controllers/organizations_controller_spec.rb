require 'rails_helper'

RSpec.describe Api::OrganizationsController, :type => :controller do

  let(:valid_attributes) { FactoryGirl.attributes_for(:organization) }

  let(:new_attributes) {
    { name: 'Testing foobar',
      city: 'Allston',
      state_province: 'Massachusetts',
      phone_number: '123456789',
      phone_extension: '90',
      country: 'United States',
      website: 'http://www.example.com/foobar',
      email_address: 'foobar@example.com',
      phone_preferred: false }
    }

  let(:invalid_attributes) {
    { name: ' ' }
  }

  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all organizations as @organizations" do
      organization = Organization.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:organizations)).to eq([organization])
    end
  end

  describe "GET show" do
    it "assigns the requested organization as @organization" do
      organization = Organization.create! valid_attributes
      get :show, {:id => organization.to_param}, valid_session
      expect(assigns(:organization)).to eq(organization)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Organization" do
        expect {
          post :create, {:organization => valid_attributes}, valid_session
        }.to change(Organization, :count).by(1)
      end

      it "assigns a newly created organization as @organization" do
        post :create, {:organization => valid_attributes}, valid_session
        expect(assigns(:organization)).to be_a(Organization)
        expect(assigns(:organization)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved organization as @organization" do
        post :create, {:organization => invalid_attributes}, valid_session
        expect(assigns(:organization)).to be_a_new(Organization)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested organization" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => new_attributes}, valid_session
        organization.reload
        new_attributes.each_pair do |key, value|
          expect(organization[key]).to eq(value)
        end
      end

      it "assigns the requested organization as @organization" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => valid_attributes}, valid_session
        expect(assigns(:organization)).to eq(organization)
      end
    end

    describe "with invalid params" do
      it "assigns the organization as @organization" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => invalid_attributes}, valid_session
        expect(assigns(:organization)).to eq(organization)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested organization" do
      organization = Organization.create! valid_attributes
      expect {
        delete :destroy, {:id => organization.to_param}, valid_session
      }.to change(Organization, :count).by(-1)
    end
  end
end
