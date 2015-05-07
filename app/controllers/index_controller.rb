get '/' do
  if session[:user] != nil
    erb :index
  else
    erb :sign_in
  end
end

post '/sign_in' do
  @user = User.find_by(username: params[:username])
  if @user.password != params[:password]
    @failed_message = "Sorry, Access Denied!"
    erb :sign_in
  else
    session[:user] = @user.id
    @tweets = Tweet.all
    erb :index
  end
end

get '/sign_out' do
  session.delete(:user)
  redirect '/'
end

get '/sign_up' do
  erb :sign_in
end

post '/sign_up' do
  @user = User.create(username: params[:username], email: params[:email], password: params[:password])
  erb :sign_in
end
