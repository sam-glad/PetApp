class Api::AdminPetApplicationsController < ApplicationController
  before_action :set_pet_application, only: [:show, :update, :destroy]

  # GET users/1/admin_pet_applications
  # GET users/1/admin_pet_applications.json
  def index
    if params['user_id'] && !params['user_id'].nil? &&
       !current_user.nil? && params['user_id'] == current_user.id
      @pet_applications = PetApplication.where(organization_id:
        [
          OrganizationMembership.select('id').where(user_id: params['user_id'], is_admin: true)
        ])

      authorize @pet_applications
      render json: @pet_applications
    else
      head 403
    end
  end
end
