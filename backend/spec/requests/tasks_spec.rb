require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let(:token) { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { { Authorization: "Bearer #{token}" } }

  describe "GET /tasks" do
    it "returns user's tasks" do
      create_list(:task, 3, user: user)
      get "/tasks", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end

  describe "POST /tasks" do
    it "creates a task" do
      post "/tasks", params: { task: { title: "Test task", status: "todo" } }, headers: headers
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["title"]).to eq("Test task")
    end
  end

  describe "PUT /tasks/:id" do
    it "updates a task" do
      task = create(:task, user: user, status: "todo")
      put "/tasks/#{task.id}", params: { task: { status: "done" } }, headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["status"]).to eq("done")
    end
  end

  describe "DELETE /tasks/:id" do
    it "deletes a task" do
      task = create(:task, user: user)
      delete "/tasks/#{task.id}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["message"]).to eq("Task deleted")
    end
  end
end
