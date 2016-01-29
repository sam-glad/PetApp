require 'rails_helper'

RSpec.describe Api::PetApplicationsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/api/organizations/1/pet_applications').to route_to('api/pet_applications#index', organization_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/api/pet_applications/1').to route_to('api/pet_applications#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/pet_applications').to route_to('api/pet_applications#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/pet_applications/1').to route_to('api/pet_applications#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/pet_applications/1').to route_to('api/pet_applications#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/pet_applications/1').to route_to('api/pet_applications#destroy', id: '1')
    end

  end
end
