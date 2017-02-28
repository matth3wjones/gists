get '/login' do
  erb :'users/login'
end

post '/login' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(user.email, params[:password])
    session[:id] = user.id
    redirect "/users/#{user.id}/profile"
  else
    erb :'users/login'
  end
end

get '/logout' do
  session[:id] = nil
  redirect '/entries'
end
