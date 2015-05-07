require_relative '../spec_helper'

describe "/users" do
  before do
    5.times do
      User.create(username: Faker::Name.name,
                email: Faker::Internet.email,
                password: Faker::Internet.password(8))
    end
    @current_user = User.all.first.id
    @session = {"rack.session" => {user: @current_user}}
  end

  describe "GET /users" do
    before do
      get "/users", {}, @session
    end

    it "returns HTTP status code 200" do
      expect(last_response.status).to eq(200)
    end

    it "displays the Users page" do
      expect(last_response.body).to include("Users")
    end

    it "displays users from the DB" do
      expect(last_response.body).to include("</form>")
    end
  end

  describe "POST /users/follow" do
    before do
      @user_id_to_follow = User.all.last.id
      post "/users/follow/#{@user_id_to_follow}", {}, @session
    end

    it "adds specified user to current user's 'followees'" do
      expect(User.find(@current_user).followees).to include(User.find(@user_id_to_follow))
    end
  end

  after do
    User.destroy_all
  end
end
