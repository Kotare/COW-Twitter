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

# DELETE >>>>>>>>>>>>>>>>>>>>>>>>
    # it "adds specified user to current user's 'followees'" do
    #   expect(Connection.all).to be 42
    # end
    # it "adds specified user to current user's 'followees'" do
    #   expect(User.all).to eq(42)
    # end
# <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    it "adds specified user to current user's 'followees'" do
      current_user = User.find_by(id: @current_user)
      followed_user = User.find_by(id: @user_id_to_follow)
      expect(current_user.followees).to include(followed_user)
    end
  end

  after do
    User.destroy_all
    Connection.destroy_all
  end
end
