
class UsersController < ApplicationController

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect to "/tasks"
       #validations passed
    else
      erb :'users/signup'
        #validations failed
    end
    # if params[:username] == "" || params[:email] == "" || params[:password] == ""
    #   redirect '/signup'
    # else
    #   @user = User.create(:username => params[:username], :email=> params[:email], :password => params[:password])
    #   session[:user_id] = @user.id
    #
    #   redirect '/task'
    # end
  end
  #
  # post '/signup' do
  #  @user = User.new
  #  @user.username = params[:username]
  #  @user.email = params[:email]
  #  @user.password = params[:password]
  #  if @user.save
  #    redirect '/login'
  #  else
  #    erb :'users/signup' #we render instead of redirect when the current request has the data we need if we dont need the data anymore we can redirect
  #   end
  # end



  get '/login' do
    if logged_in?
      redirect '/tasks'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:email => params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tasks'
    else
      redirect '/signup'
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
