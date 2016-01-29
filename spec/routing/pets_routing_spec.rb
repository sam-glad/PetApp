require 'rails_helper'

RSpec.describe Api::PetsController, :type => :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/api/pets').to route_to('api/pets#index')
    end

    it 'routes to #show' do
      expect(:get => '/api/pets/1').to route_to('api/pets#show', :id => '1')
    end

    it 'routes to #create' do
      expect(:post => '/api/pets').not_to be_routable
    end

    it 'routes to #update' do
      expect(:put => '/api/pets/1').to route_to('api/pets#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(:delete => '/api/pets/1').not_to be_routable
    end

  end
end
