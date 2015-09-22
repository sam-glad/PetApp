require 'rails_helper'

RSpec.describe "ApplicationForms", :type => :request do
  describe "GET /application_forms" do
    it "works! (now write some real specs)" do
      get application_forms_path
      expect(response.status).to be(200)
    end
  end
end
