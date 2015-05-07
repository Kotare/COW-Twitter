require_relative '../spec_helper'

describe "/tweets" do
  before do
    1.times do
      User.create(username: Faker::Name.name,
                email: Faker::Internet.email,
                password: Faker::Internet.password(8))
    end
    @current_user = 1
    @session = {"rack.session" => {user: @current_user}}
  end

  describe "POST '/tweet'" do
    before do
      @tweet = Tweet.create(content: Faker::Lorem.sentence )
      @valid_params = {content: @tweet.content}
      post '/tweet', @valid_params
    end

    it "returns HTTP status code 200" do
      expect(last_response.status).to eq(200)
    end

    it "displays the Index page" do
      expect(last_response.body).to include("Index")
    end
  end


  after do
    User.destroy_all
    Tweet.destroy_all
  end
end
