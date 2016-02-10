require 'rails_helper'

RSpec.describe Api::OrganizationMembershipsController, type: :controller do

  let(:organization) { FactoryGirl.create(:organization) }


  let(:new_attributes) {
    { }
  }

  let(:invalid_attributes) {
    { name: ' ' }
  }

  def organization_membership_specified
    return OrganizationMembership.create
  end

  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  let(:user) { FactoryGirl.create(:user) }

  let(:organization_membership) { OrganizationMembership.create(user_id: user.id, organization_id: organization.id) }

  before(:each) do
    login(user)
  end

  describe 'GET #index' do
    context 'with an authorized user' do
      it 'assigns an organization\'s pet_applications as @pet_applications' do
        # pet_application = PetApplication.create! valid_attributes(user)
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
      it 'assigns the requested organization as @organization' do
        get :show, {:id => organization_membership.to_param}
        expect(assigns(:organization_membership)).to eq(organization_membership)
      end
    end
    # context 'with an unauthorized user' do
    #   it 'returns 403' do
    #     expect(response).to have_http_status(403)
    #   end
    # end
  end
end
