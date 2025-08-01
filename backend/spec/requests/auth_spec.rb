require 'rails_helper'

RSpec.describe "Auth", type: :request do
  let(:user) { create(:user) }

  describe "POST /register" do
    it "registers a user" do
      post "/register", params: { email: "new@example.com", password: "123456" }
      expect(response).to have_http_status(:created)
    end
  end

  describe "POST /login" do
    it "returns a JWT on success" do
      post "/login", params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key("token")
    end

    it "fails with wrong credentials" do
      post "/login", params: { email: user.email, password: "wrongpass" }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /me" do
    it "returns user info with valid token" do
      token = JsonWebToken.encode(user_id: user.id)
      get "/me", headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["email"]).to eq(user.email)
    end
  end
end
