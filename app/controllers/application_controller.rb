require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

    get '/' do
      erb :index
    end

    helpers do

      def logged_in?
        !!current_user
      end

      def current_user
        @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
      end
        #
        # def login(email,password)
        #   #check if the user with this email actually exist
        #   #if so set the session
        #   user = User.find_by(:email => email)
        #   if user && user.authenticate(password)
        #     session[:email] = user.email
        #   else
        #     redirect '/login'
        #   end
        # end
    end
  end
