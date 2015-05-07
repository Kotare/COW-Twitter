require_relative '../spec_helper'

describe "/tweets" do

  before do
    5.times do
      User.create(username: Faker::Name.name,
                email: Faker::Internet.email,
                password: Faker::Internet.password(8))
    end
    @current_user = User.all.first.id
    @session = {"rack.session" => {user: @current_user}}
  end

  describe "POST '/tweet'" do

    before do
      get '/'
      @user = User.create(username: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
      @valid_params = {username: @user.username, password: @user.password}
      post "/sign_in", @valid_params , @session

      @valid_params = {content: Faker::Lorem.sentence, user_id: session[:user]}
      post '/tweet', @valid_params, @session
    end

    it "returns HTTP status code 200" do
      expect(last_response.status).to eq(200)
    end

    it "displays the Index page" do
      expect(last_response.body).to include("Logout:")
    end

    it "creates a tweet with the given params" do
      expect(Tweet.find_by(content: @valid_params[:content], user_id: session[:user]))
    end

    it "displays the content of tweet on index page" do
      expect(last_response.body).to include(@valid_params[:content])
    end

  end


  after do
    User.destroy_all
    Tweet.destroy_all
  end
end
