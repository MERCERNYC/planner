class TasksController < ApplicationController

#allows the view to access all the posts in the database through the instance variable @tasks
#index action
  get '/tasks'do
    @tasks = Task.all
    erb :'tasks/index'
  end

#new action
#request to load the form
  get '/tasks/new' do
    if logged_in?
      erb :'tasks/create'
    else
      redirect to '/login'
    end
  end

#create a new task
  post '/tasks' do
    @tasks = Task.create(:name => params[:name])
    redirect "/tasks/#{@tasks.id}"
  end

  get '/tasks/:id' do
    if logged_in?
    @tasks = Task.find_by(params[:id])
     erb :"tasks/show"
   end
  end

#show action
#load edit form
  get '/tasks/:id/edit' do
    @tasks = Task.find_by(params[:id])
    erb :"tasks/edit"
  end

#edit action
  patch '/tasks/:id' do
     @tasks = Task.find_by(params[:id])
     @tasks.name = params[:name]
     @tasks.save
     redirect to '/tasks'
  end

  delete '/tasks/:id/delete' do
    @tasks = Task.find_by(params[:id])
    @tasks.delete
    redirect to '/tasks'
  end

end
