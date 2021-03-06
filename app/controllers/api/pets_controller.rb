class Api::PetsController < ApplicationController
  before_action :set_pet, only: [:show, :update, :destroy]

  # GET /pets
  # GET /pets.json
  def index
    @pets = Pet.all

    render json: @pets
  end

  # GET /pets/1
  # GET /pets/1.json
  def show
    render json: @pet
  end

  # PATCH/PUT /pets/1
  # PATCH/PUT /pets/1.json
  def update
    @pet = Pet.find(params[:id])
    authorize @pet

    if @pet.update(pet_params)
      head :no_content
    else
      render json: @pet.errors, status: :unprocessable_entity
    end
  end

  private

    def set_pet
      @pet = Pet.find(params[:id])
    end

    def pet_params
      params.require(:pet).permit(:is_fosterable, :is_adoptable,
        :foster_application_id, :adoption_application_id, :status)
    end
end
