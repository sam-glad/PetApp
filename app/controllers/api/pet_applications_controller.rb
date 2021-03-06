class Api::PetApplicationsController < ApplicationController
  before_action :set_pet_application, only: [:show, :update, :destroy]

  # GET organizations/1/pet_applications
  # GET organizations/1/pet_applications.json
  def index
    @pet_applications = PetApplication.where(organization_id: params['organization_id'])
    authorize @pet_applications

    render json: @pet_applications
  end

  # GET /pet_applications/1
  # GET /pet_applications/1.json
  def show
    authorize @pet_application
    render json: @pet_application
  end

  # POST /pet_applications
  # POST /pet_applications.json
  def create
    @pet_application = PetApplication.new(pet_application_create_params)
    @pet_application.status = 0 # TODO: Replace with enum
    @pet_application.user_id = current_user.id
    @pet_application.organization_id = @pet_application.pet.organization_id

    if @pet_application.save
      render json: @pet_application, status: :created, location: nil
    else
      render json: @pet_application.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /pet_applications/1
  # PATCH/PUT /pet_applications/1.json
  def update
    @pet_application = PetApplication.find(params[:id])
    authorize @pet_application

    if @pet_application.update(pet_application_edit_params)
      head :no_content
    else
      render json: @pet_application.errors, status: :unprocessable_entity
    end
  end

  # DELETE /pet_applications/1
  # DELETE /pet_applications/1.json
  def destroy
    authorize @pet_application
    @pet_application.destroy

    head :no_content
  end

  private

    def set_pet_application
      @pet_application = PetApplication.find(params[:id])
    end

    def pet_application_create_params
      params.require(:pet_application).permit(:pet_id, :application_type,
        questions_attributes: [:body, answers_attributes: [:body] ])
    end

    def pet_application_edit_params
      params.require(:pet_application).permit(:status)
    end
end
