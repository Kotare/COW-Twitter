
get '/users' do
  pp session[:user]
  @users = User.all
  @current_user = User.find(session[:user])
  erb :users
end

post "/users/follow/:user_id" do
  new_connection = Connection.new(follower_id: session[:user], followee_id: params[:user_id].to_i)
  if new_connection.save
    # binding.pry
    session[:flash] = "Followed!"
  else
    session[:flash] = "ERROR>?>?!"
  end
  redirect "/users"
end

