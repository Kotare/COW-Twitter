get '/' do
  if session[:user] != nil
    @user = User.find_by(id: session[:user])
    @tweets = []
    @user.tweets.each {|tweet| @tweets << tweet}
    @user.followees.each do |followee|
      followee.tweets.each {|tweet| @tweets << tweet}
    end
    @tweets = @tweets.uniq
    # Below is for nav bar 'my profile' link finding
    @current_user_id = session[:user]
    # #TODO: sort tweets by date/time
    # @tweets.sort {|a,b|}

    erb :index

  else
    @failed_message = session[:flash]
    erb :sign_in
  end
end

post '/sign_in' do
  @user = User.find_by(username: params[:username])
  if @user.password != params[:password]
    session[:flash] = "Sorry, Access Denied!"
    put '>'*50
    pp 'failed login'
  else
    put '>'*50
    pp 'redirecting'
    session[:user] = @user.id
  end
  redirect "/"
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
