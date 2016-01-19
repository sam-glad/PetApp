class ApplicationFormsController < ApplicationController
  before_action :set_application_form, only: [:show, :update, :destroy]

  # GET /application_forms
  # GET /application_forms.json
  def index
    @application_forms = ApplicationForm.where(organization_id: params['organization_id'])
    authorize @application_forms

    render json: @application_forms
  end

  # GET /application_forms/1
  # GET /application_forms/1.json
  def show
    authorize @application_form
    render json: @application_form
  end

  # POST /application_forms
  # POST /application_forms.json
  def create
    @application_form = ApplicationForm.new(application_form_params)
    authorize @application_form

    if @application_form.save
      render json: @application_form, status: :created, location: @application_form
    else
      render json: @application_form.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /application_forms/1
  # PATCH/PUT /application_forms/1.json
  def update
    @application_form = ApplicationForm.find(params[:id])
    authorize @application_form

    if @application_form.update(application_form_params)
      head :no_content
    else
      render json: @application_form.errors, status: :unprocessable_entity
    end
  end

  # DELETE /application_forms/1
  # DELETE /application_forms/1.json
  def destroy
    authorize @application_form
    @application_form.destroy

    head :no_content
  end

  private

    def set_application_form
      @application_form = ApplicationForm.find(params[:id])
    end

    def application_form_params
      params.require(:application_form).permit(:name, :organization_id, questions_attributes:
        [:id, :body, :input_type, :is_required, :position, :_destroy,
        answers_attributes: [:id, :body, :_destroy] ])
    end
end
