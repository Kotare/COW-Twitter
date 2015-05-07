get '/' do
  if session[:user] != nil
    erb :index
  else
    erb :sign_in
  end
end

post '/sign_in' do
  @user = User.find_by(email: params[:email])
  if params[:password] == @user.password
    session[:user] = @user
    erb :index
  else
    @failed_message = "Sorry, Access Denied!"
    erb :sign_in
  end
end

get '/sign_out' do
  session.delete(:user)
  redirect '/'
end
