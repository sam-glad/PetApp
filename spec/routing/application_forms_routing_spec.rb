require 'rails_helper'

RSpec.describe Api::ApplicationFormsController, :type => :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: 'api/organizations/1/application_forms').to route_to('api/application_forms#index', organization_id: '1')
    end

    it 'routes to #show' do
      expect(get: 'api/application_forms/1').to route_to('api/application_forms#show', :id => '1')
    end

    it 'routes to #create' do
      expect(post: 'api/application_forms').to route_to('api/application_forms#create')
    end

    it 'routes to #update' do
      expect(put: 'api/application_forms/1').to route_to('api/application_forms#update', :id => '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'api/application_forms/1').to route_to('api/application_forms#destroy', :id => '1')
    end

  end
end
