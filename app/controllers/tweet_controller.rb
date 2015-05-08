
post '/tweet' do
  @tweet = Tweet.create(content: params[:content], user_id: session[:user])

  @user = User.find_by(id: session[:user])
  @tweets = []
  @tweets << @user.tweets
  @user.followees.each do |user|
     @tweets << user.tweets
  end
  #TODO: sort tweets by date/time

  redirect '/'
end


