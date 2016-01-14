require 'rails_helper'

RSpec.describe PetsController, :type => :controller do

  def valid_attributes(user = nil, user_can_edit_pets = false)
    organization = FactoryGirl.create(:organization)
    user ||= FactoryGirl.create(:user)
    if user_can_edit_pets
      OrganizationMembership.create(user_id: user.id,
        organization_id: organization.id, can_edit_all_pets: true)
    end

    return {
      animal: 'Dog',
      is_mix?: false,
      age: 'Young',
      name: 'Doggie',
      size: 'XL',
      sex: 'M',
      description: 'A description',
      good_with_dogs: true,
      good_with_cats: false,
      good_with_kids: false,
      is_adoptable: true,
      is_fosterable: true,
      breeds: [FactoryGirl.create(:breed)],
      foster_application_id: ApplicationForm.create.id,
      organization: organization
    }
  end

  def invalid_attributes
    return { foster_application_id: ApplicationForm.create.id }
  end

  def new_attributes
    return { is_adoptable: false }
  end

  # TODO: Move this somewhere for common access
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login(user)
  end

  describe "GET index" do
    it "assigns all pets as @pets" do
      pet = Pet.create! valid_attributes
      get :index, {}
      expect(assigns(:pets)).to eq([pet])
    end
  end

  describe "GET show" do
    it "assigns the requested pet as @pet" do
      pet = Pet.create! valid_attributes
      get :show, {:id => pet.to_param}
      expect(assigns(:pet)).to eq(pet)
    end
  end

  describe 'PUT update' do
    context 'with an authorized user' do
      describe 'with valid params' do
        it 'updates the requested pet' do
          pet = Pet.create! valid_attributes(user, true)
          put :update, {:id => pet.to_param, :pet => new_attributes}
          pet.reload
          new_attributes.each_pair do |key, value|
            expect(pet[key]).to eq(value)
          end
        end

        it 'assigns the requested pet as @pet' do
          pet = Pet.create! valid_attributes(user, true)
          put :update, {:id => pet.to_param, :pet => valid_attributes}
          expect(assigns(:pet)).to eq(pet)
        end
      end

      describe 'with invalid params' do
        it 'assigns the pet as @pet' do
          pet = Pet.create! valid_attributes(user, true)
          put :update, {:id => pet.to_param, :pet => invalid_attributes}
          expect(assigns(:pet)).to eq(pet)
        end
      end
    end

    context 'with an unauthorized user' do
      it 'returns 403 Forbidden' do
        pet = Pet.create! valid_attributes
        put :update, {:id => pet.to_param, :pet => valid_attributes}
        expect(response).to have_http_status(403)
      end

      it 'fails to update the requested pet' do
        pet = Pet.create! valid_attributes
        put :update, {:id => pet.to_param, :pet => new_attributes}
        pet.reload
        new_attributes.each_pair do |key, value|
          expect(pet[key]).not_to eq(value)
        end
      end
    end
  end
end
