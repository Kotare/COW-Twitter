
post '/tweet' do
  @tweet = Tweet.create(content: params[:content], user_id: session[:user])
  erb :index
end


