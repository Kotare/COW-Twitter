require_relative '../spec_helper'

describe "GET /users" do
  before do
    get "/users"
  end

    it "returns HTTP status code 200" do
      expect(last_response.status).to eq(200)
    end

    it "displays the Users page" do
      expect(last_response.body).to include("Users")
    end
end

describe "POST /users" do
  before do
    post
  end
end
