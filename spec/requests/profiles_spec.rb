require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /dashboard" do
    it "returns http success" do
      get "/profiles/dashboard"
      expect(response).to have_http_status(:success)
    end
  end

end
