require "rails_helper"

RSpec.describe OrganizationMembershipsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/organization_memberships").to route_to("organization_memberships#index")
    end

    it "routes to #new" do
      expect(:get => "/organization_memberships/new").to route_to("organization_memberships#new")
    end

    it "routes to #show" do
      expect(:get => "/organization_memberships/1").to route_to("organization_memberships#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/organization_memberships/1/edit").to route_to("organization_memberships#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/organization_memberships").to route_to("organization_memberships#create")
    end

    it "routes to #update" do
      expect(:put => "/organization_memberships/1").to route_to("organization_memberships#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/organization_memberships/1").to route_to("organization_memberships#destroy", :id => "1")
    end

  end
end
