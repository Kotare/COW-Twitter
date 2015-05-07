
get '/users' do
  pp User.all
  @users = User.all
  pp session
  @current_user = User.find(session[:user])
  erb :users
end

post '/users/follow/:user_id' do
  Connection.create(follower_id: session[:user], followee_id: params[:user_id])
  redirect "/users"
end

