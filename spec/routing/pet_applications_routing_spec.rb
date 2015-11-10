require 'rails_helper'

RSpec.describe PetApplicationsController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/organizations/1/pet_applications').to route_to('pet_applications#index', organization_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/pet_applications/1').to route_to('pet_applications#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pet_applications').to route_to('pet_applications#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/pet_applications/1').to route_to('pet_applications#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/pet_applications/1').to route_to('pet_applications#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pet_applications/1').to route_to('pet_applications#destroy', id: '1')
    end

  end
end
