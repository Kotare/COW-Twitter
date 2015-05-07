require 'spec_helper'
require 'uri'

describe "IndexController" do

  before do
    5.times do
      User.create(username: Faker::Name.name,
                email: Faker::Internet.email,
                password: Faker::Internet.password(8))
    end
    @current_user = User.all.first.id
    @session = {"rack.session" => {user: @current_user}}
  end

  describe "GET '/'" do

    before do
      get '/'
    end

    it "returns an HTTP status code of 200" do
      expect(last_response.status).to eq(200)
    end

    it "renders the sign-in / sign-up view" do
      expect(last_response.body).to include("Password:")
    end

  end

  describe "POST '/sign_in'" do

    before do
      @user = User.create(username: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)

      @valid_params = {username: @user.username, password: @user.password}
      post "/sign_in", @valid_params , @session
    end

    it "returns an HTTP status code of 200" do
      expect(last_response.status).to eq(200)
    end

    it "renders the index page" do
      expect(last_response.body).to include("Logout:")
    end

  end

  describe "GET '/sign_out'" do

    before do
      get '/sign_out', {}, @session
    end

    it "returns an HTTP status code of 302" do
      expect(last_response.status).to eq(302)
    end

    it "redirects the user to GET /" do
      expect(URI(last_response.location).path).to eq('/')
    end

    # it "renders the sign-in / sign-up view" do
    #   expect(last_response.body).to include("Password:")
    # end

  end

  describe "POST '/sign_up'" do

    before do
      @valid_params = {username: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password}
      post "/sign_up", @valid_params , @session
    end

    it "returns an HTTP status code of 200" do
      expect(last_response.status).to eq(200)
    end

    it "renders the sign-in view" do
      expect(last_response.body).to include("Password:")
     end

    it "creates a new user with given params" do
      expect(User.find_by(username: @valid_params[:username], email: @valid_params[:email], password: @valid_params[:password])).to be_truthy
    end

  end

  after do
    User.destroy_all
  end

end