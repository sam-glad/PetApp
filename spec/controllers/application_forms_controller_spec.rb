require 'rails_helper'

RSpec.describe ApplicationFormsController, :type => :controller do

  def valid_attributes(user = nil)
    organization = FactoryGirl.create(:organization)
    if user
      OrganizationMembership.create(user_id: user.id, organization_id: organization.id,
        can_manage_application_forms: true)
    else
      user = FactoryGirl.create(:user)
    end

    return { name: 'My First Application Form',
             organization: organization
           }
  end

  def invalid_attributes
    return { name: nil }
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

  describe 'GET index' do
    context 'with an authorized user' do
      it 'assigns an organization\'s application_forms as @application_forms' do
        application_form = ApplicationForm.create! valid_attributes(user)
        get :index, {organization_id: application_form.id}
        expect(assigns(:application_forms)).to eq([application_form])
      end
      it 'returns 200' do
        application_form = ApplicationForm.create! valid_attributes(user)
        get :index, {organization_id: application_form.id}
        expect(response).to have_http_status(200)
      end
    end
    context 'with an unauthorized user' do
      it 'returns 403' do
        application_form = ApplicationForm.create! valid_attributes
        get :index, {organization_id: application_form.id}
        expect(response).to have_http_status(403)
      end
    end
  end

  describe "GET show" do
    context 'with an authorized user' do
      it 'assigns the requested application_form as @application_form' do
        application_form = ApplicationForm.create! valid_attributes(user)
        get :show, {:id => application_form.to_param}
        expect(assigns(:application_form)).to eq(application_form)
      end
      it 'returns 200' do
        application_form = ApplicationForm.create! valid_attributes(user)
        get :show, {:id => application_form.to_param}
        expect(response).to have_http_status(200)
      end
    end
    context 'with an unauthorized user' do
      it 'returns 403' do
        application_form = ApplicationForm.create! valid_attributes
        get :show, {:id => application_form.to_param}
        expect(response).to have_http_status(403)
      end
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ApplicationForm" do
        expect {
          post :create, {:application_form => valid_attributes}
        }.to change(ApplicationForm, :count).by(1)
      end

      it "assigns a newly created application_form as @application_form" do
        post :create, {:application_form => valid_attributes}
        expect(assigns(:application_form)).to be_a(ApplicationForm)
        expect(assigns(:application_form)).to be_persisted
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved application_form as @application_form" do
        post :create, {:application_form => invalid_attributes}
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
        put :update, {:id => application_form.to_param, :application_form => new_attributes}
        application_form.reload
        new_attributes.each_pair do |key, value|
          expect(application_form[key]).to eq(value)
        end
      end

      it "assigns the requested application_form as @application_form" do
        application_form = ApplicationForm.create! valid_attributes
        put :update, {:id => application_form.to_param, :application_form => valid_attributes}
        expect(assigns(:application_form)).to eq(application_form)
      end
    end

    describe "with invalid params" do
      it "assigns the application_form as @application_form" do
        application_form = ApplicationForm.create! valid_attributes
        put :update, {:id => application_form.to_param, :application_form => invalid_attributes}
        expect(assigns(:application_form)).to eq(application_form)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested application_form" do
      application_form = ApplicationForm.create! valid_attributes
      expect {
        delete :destroy, {:id => application_form.to_param}
      }.to change(ApplicationForm, :count).by(-1)
    end
  end

end
