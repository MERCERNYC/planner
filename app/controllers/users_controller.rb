require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect '/task'
    else
    flash[:message] = "Please signup."
    erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :email=> params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/task'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/task'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/task'
    else
      redirec '/login'
    end
  end

  get '/logout' do
    if logged_in?
        session.clear
        redirect '/login'
      else
        redirect '/'
    end
  end

end
