require 'rails_helper'

RSpec.describe Api::AdminPetApplicationsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:organization) { FactoryGirl.create(:organization) }

  def create_organization_membership(is_admin)
    OrganizationMembership.create(user_id: user.id,
      organization_id: organization.id, is_admin: is_admin)
  end

  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'GET #index' do
    context 'with no user logged in' do
      it 'returns 403' do
        get :index, {user_id: 1}
        expect(response).to have_http_status(403)
      end
    end

    context 'with the wrong user_id param' do
      it 'returns 403' do
        login(user)
        get :index, {user_id: user.id + 1}
        expect(response).to have_http_status(403)
      end
    end

    context 'with the right user_id param' do
      context 'and an unauthorized user' do
        it 'returns 403' do
          allow_any_instance_of(User).to receive(:can_view?).and_return(false)
          login(user)
          get :index, {user_id: user.id}
          expect(response).to have_http_status(403)
        end
      end
      context 'and an authorized user' do
        it 'assigns the pet applications for pets belonging to the organizations
          of which the user is an admin as @pet_applications' do
            allow_any_instance_of(User).to receive(:can_view?).and_return(true)
            create_organization_membership(true)
            pet_applications = [PetApplication.create(organization: organization,
              pet: FactoryGirl.create(:pet), user: FactoryGirl.create(:user),
              questions: [FactoryGirl.create(:question)])]
            login(user)
            get :index, {user_id: user.id}
            expect(assigns(:pet_applications)).to eq(pet_applications)
          end
      end
    end
  end
end
