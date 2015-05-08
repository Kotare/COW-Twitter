require_relative '../spec_helper'

describe "/tweets" do

  before do

    10.times do
      User.create(username: Faker::Name.name,
                  email: Faker::Internet.email,
                  password: Faker::Internet.password(8))
    end

    User.all.each do |user|
      followed_users = User.all.sample(5)
      followed_users.each do |followee|
        Connection.create(follower_id: user.id, followee_id: followee.id)
      end
      Connection.create(follower_id: user.id, followee_id: user.id)
    end

    User.all.each do |user|
      8.times do
        Tweet.create({content: Faker::Lorem.sentence, user_id: user.id})
      end
    end

    @current_user = User.all.first
    @session = {"rack.session" => {user: @current_user.id}}

  end

  describe "POST '/tweet'" do

    before do
      get '/'
      #@user = User.create(username: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)

      @valid_params = {username: @current_user.username, password: @current_user.password}
      post "/sign_in", @valid_params , @session

      @valid_params = {content: Faker::Lorem.sentence, user_id: session[:user]}
      post '/tweet', @valid_params, @session
    end

    it "returns HTTP status code 302" do
      expect(last_response.status).to eq(302)
    end

    it "displays the Index page" do
      expect(last_response.body).to include("Logout:")
    end


    it "creates a tweet with the given params" do
      expect(Tweet.find_by(content: @valid_params[:content], user_id: session[:user]))
    end

    # it "displays the content of tweet on index page" do
    #   expect(last_response.body).to include(@valid_params[:content])
    # end

  end


  after do
    User.destroy_all
    Tweet.destroy_all
    Connection.destroy_all
  end
end
