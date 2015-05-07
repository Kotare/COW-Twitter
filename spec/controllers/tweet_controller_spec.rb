
describe "POST '/tweet'" do

  before do
    @tweet = Tweet.create(content: Faker::Lorem.sentence )

    @valid_params = {content: @tweet.content}
    post '/tweet', @valid_params
  end
end
