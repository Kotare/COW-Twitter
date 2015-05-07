require 'spec_helper'
require 'uri'

describe "IndexController" do

  describe "GET '/'" do

    before do
      get '/'
    end

    it "returns an HTTP status code of 200" do
      expect(last_response.status).to eq(200)
    end

    it "renders the sign-in / sign-up view" do
      expect(last_response.body).to include("password")
    end

  end

  describe "POST '/sign_in'" do

    before do
      @user = User.create(username: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)

      @valid_params = {username: @user.username, password: @user.password}
      post '/sign_in', @valid_params
    end

    it "returns an HTTP status code of 200" do
      expect(last_response.status).to eq(200)
    end

    it "renders the index page" do
      expect(last_response.body).to include("Logout:")
    end

    after do
      User.destroy_all
    end
  end

end