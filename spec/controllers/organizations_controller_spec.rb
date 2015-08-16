require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe OrganizationsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Organization. As you add validations to Organization, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # OrganizationsController. Be sure to keep this updated too.
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

  describe "GET new" do
    it "assigns a new organization as @organization" do
      get :new, {}, valid_session
      expect(assigns(:organization)).to be_a_new(Organization)
    end
  end

  describe "GET edit" do
    it "assigns the requested organization as @organization" do
      organization = Organization.create! valid_attributes
      get :edit, {:id => organization.to_param}, valid_session
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

      it "redirects to the created organization" do
        post :create, {:organization => valid_attributes}, valid_session
        expect(response).to redirect_to(Organization.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved organization as @organization" do
        post :create, {:organization => invalid_attributes}, valid_session
        expect(assigns(:organization)).to be_a_new(Organization)
      end

      it "re-renders the 'new' template" do
        post :create, {:organization => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested organization" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => new_attributes}, valid_session
        organization.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested organization as @organization" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => valid_attributes}, valid_session
        expect(assigns(:organization)).to eq(organization)
      end

      it "redirects to the organization" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => valid_attributes}, valid_session
        expect(response).to redirect_to(organization)
      end
    end

    describe "with invalid params" do
      it "assigns the organization as @organization" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => invalid_attributes}, valid_session
        expect(assigns(:organization)).to eq(organization)
      end

      it "re-renders the 'edit' template" do
        organization = Organization.create! valid_attributes
        put :update, {:id => organization.to_param, :organization => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
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

    it "redirects to the organizations list" do
      organization = Organization.create! valid_attributes
      delete :destroy, {:id => organization.to_param}, valid_session
      expect(response).to redirect_to(organizations_url)
    end
  end

end
