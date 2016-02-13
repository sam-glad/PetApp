class Api::OrganizationMembershipsController < ApplicationController
  before_action :set_organization_membership, only: [:show, :update, :destroy]

  # GET /users/1/organization_memberships
  # GET /users/1/organization_memberships.json
  def index
    @organization_memberships = OrganizationMembership.where(user_id: params['user_id'])
    authorize @organization_memberships

    render json: @organization_memberships
  end

  # GET /organization_memberships/1
  # GET /organization_memberships/1.json
  def show
    authorize @organization_membership
    render json: @organization_membership
  end

  # POST /organization_memberships
  # POST /organization_memberships.json
  def create
    @organization_membership = OrganizationMembership.new(organization_membership_create_params)
    # authorize @organization_membership

    if @organization_membership.save
      render json: @organization_membership, status: :created, location: nil
    else
      render json: @organization_membership.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /organization_memberships/1
  # PATCH/PUT /organization_memberships/1.json
  def update
    authorize @organization_membership

    if @organization_membership.update(organization_membership_update_params)
      head :no_content
    else
      render json: @organization_membership.errors, status: :unprocessable_entity
    end
  end

  private

    def set_organization_membership
      @organization_membership = OrganizationMembership.find(params[:id])
    end

    def organization_membership_create_params
      params.require(:organization_membership).permit(:organization_id, :user_id, :is_admin)
    end

    def organization_membership_update_params
      params.require(:organization_membership).permit(:is_admin)
    end
end
