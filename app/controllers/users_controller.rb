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
  end

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
      flash[:notice] = "Please sign up to Planner before login."
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
