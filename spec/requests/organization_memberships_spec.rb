require 'rails_helper'

RSpec.describe "OrganizationMemberships", :type => :request do
  describe "GET /organization_memberships" do
    it "works! (now write some real specs)" do
      get organization_memberships_path
      expect(response.status).to be(200)
    end
  end
end
