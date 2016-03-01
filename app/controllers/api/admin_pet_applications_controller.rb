class Api::AdminPetApplicationsController < ApplicationController
  before_action :set_pet_application, only: [:show, :update, :destroy]

  # GET users/1/admin_pet_applications
  # GET users/1/admin_pet_applications.json
  def index
    if params['user_id'] && !params['user_id'].nil? && !current_user.nil? && params['user_id'].to_i == current_user.id
      admin_organization_ids = current_user.get_admin_organization_ids

      if !admin_organization_ids.present?
        render json: []
      end
      
      @pet_applications = PetApplication.where(organization_id: current_user.get_admin_organization_ids)
      authorize @pet_applications
      render json: @pet_applications
    else
      head 403
    end
  end
end
