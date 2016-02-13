require 'rails_helper'

RSpec.describe Api::OrganizationMembershipsController, type: :controller do

  let(:organization) { FactoryGirl.create(:organization) }
  let(:user) { FactoryGirl.create(:user) }

  def valid_attributes(is_admin)
    {
      organization_id: organization.id,
      user_id: user.id,
      is_admin: is_admin
    }
  end

  let(:invalid_attributes) {
    { user_id: user.id + 1 }
  }

  let(:new_attributes) {
    { is_admin: false }
  }

  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  before(:each) do
    login(user)
  end

  describe 'GET #index' do
    context 'with an authorized user' do
      it 'assigns an organization\'s pet_applications as @pet_applications' do
        organization_membership = OrganizationMembership.create! valid_attributes(true)
        get :index, {user_id: organization_membership.user_id}
        expect(assigns(:organization_memberships)).to eq([organization_membership])
      end
    end
    # context 'with an unauthorized user' do
    #   it 'returns 403' do
    #     expect(response).to have_http_status(403)
    #   end
    # end
  end

  describe 'GET show' do
    context 'with an authorized user' do
      it 'assigns the requested organization as @organization_membership' do
        organization_membership = OrganizationMembership.create! valid_attributes(true)
        get :show, {id: organization_membership.to_param}
        expect(assigns(:organization_membership)).to eq(organization_membership)
      end
    end
    # context 'with an unauthorized user' do
    #   it 'returns 403' do
    #     expect(response).to have_http_status(403)
    #   end
    # end
  end

  # describe 'POST create' do
  #   context 'with valid params' do
  #     it 'creates a new OrganizationMembership' do
  #       expect {
  #         post :create, {organization_membership: valid_attributes(true)}
  #       }.to change(OrganizationMembership, :count).by(1)
  #     end
  #
  #     it 'assigns a newly created organization membership as @organization_membership' do
  #       post :create, {organization_membership: valid_attributes}
  #       expect(assigns(:organization_membership)).to be_a(OrganizationMembership)
  #       expect(assigns(:organization_membership)).to be_persisted
  #     end
  #   end
  # end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested organization' do
        organization_membership = OrganizationMembership.create! valid_attributes(true)
        put :update, {id: organization_membership.to_param, organization_membership: new_attributes}
        organization_membership.reload
        new_attributes.each_pair do |key, value|
          expect(organization_membership[key]).to eq(value)
        end
      end

      it 'assigns the requested organization as @organization' do
        organization_membership = OrganizationMembership.create! valid_attributes(true)
        put :update, {id: organization_membership.to_param, organization_membership: valid_attributes(true)}
        expect(assigns(:organization_membership)).to eq(organization_membership)
      end
    end

    describe 'with invalid params' do
      it 'assigns the organization as @organization' do
        organization_membership = OrganizationMembership.create! valid_attributes(true)
        put :update, {id: organization_membership.to_param, organization_membership: invalid_attributes}
        expect(assigns(:organization_membership)).to eq(organization_membership)
      end
    end
  end
end
