require 'rails_helper'

RSpec.describe PetsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Pet. As you add validations to Pet, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
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
      breeds: [FactoryGirl.create(:breed)],
      foster_application_id: ApplicationForm.create.id
    }
  }

  let(:invalid_attributes) {
    {
      foster_application_id: ApplicationForm.create.id
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PetsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all pets as @pets" do
      pet = Pet.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:pets)).to eq([pet])
    end
  end

  describe "GET show" do
    it "assigns the requested pet as @pet" do
      pet = Pet.create! valid_attributes
      get :show, {:id => pet.to_param}, valid_session
      expect(assigns(:pet)).to eq(pet)
    end
  end

  # describe "POST create" do
  #   describe "with valid params" do
  #     it "creates a new Pet" do
  #       expect {
  #         post :create, {:pet => valid_attributes}, valid_session
  #       }.to change(Pet, :count).by(1)
  #     end
  #
  #     it "assigns a newly created pet as @pet" do
  #       post :create, {:pet => valid_attributes}, valid_session
  #       expect(assigns(:pet)).to be_a(Pet)
  #       expect(assigns(:pet)).to be_persisted
  #     end
  #   end
  #
  #   describe "with invalid params" do
  #     it "assigns a newly created but unsaved pet as @pet" do
  #       post :create, {:pet => invalid_attributes}, valid_session
  #       expect(assigns(:pet)).to be_a_new(Pet)
  #     end
  #   end
  # end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {
          foster_application_id: ApplicationForm.create.id
        }
      }

      it "updates the requested pet" do
        pet = Pet.create! valid_attributes
        put :update, {:id => pet.to_param, :pet => new_attributes}, valid_session
        pet.reload
        new_attributes.each_pair do |key, value|
          expect(pet[key]).to eq(value)
        end
      end

      it "assigns the requested pet as @pet" do
        pet = Pet.create! valid_attributes
        put :update, {:id => pet.to_param, :pet => valid_attributes}, valid_session
        expect(assigns(:pet)).to eq(pet)
      end
    end

    describe "with invalid params" do
      it "assigns the pet as @pet" do
        pet = Pet.create! valid_attributes
        put :update, {:id => pet.to_param, :pet => invalid_attributes}, valid_session
        expect(assigns(:pet)).to eq(pet)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested pet" do
      pet = Pet.create! valid_attributes
      expect {
        delete :destroy, {:id => pet.to_param}, valid_session
      }.to change(Pet, :count).by(-1)
    end
  end

end
