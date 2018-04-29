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
      erb :'tasks/new'
    else
      redirect to '/login'
    end
  end

#create a new task
  post '/tasks' do
    if logged_in?
      @tasks = Task.create(:name => params[:name])
      redirect "/tasks/#{@tasks.id}"
    else
      erb '/tasks/create'
    end
  end

  get '/tasks/:id' do
    if logged_in?
    @tasks = Task.find_by(params[:id])
     erb :"tasks/show"
    else
      redirect '/login'
    end
  end

#show action
#load edit form
  get '/tasks/:id/edit' do
    if logged_in?
     @tasks = Task.find_by(params[:id])
      erb :"tasks/edit"
    else
     redirect to '/login'
    end
  end

#edit action
  patch '/tasks/:id' do
    if logged_in?
     @tasks = Task.find_by(params[:id])
     @tasks.name = params[:name]
     @tasks.save
     erb :'tasks/show'
     # redirect to "/tasks/#{@tasks.id}"
    else
     redirect to "/tasks/#{@tasks.id}/edit"
    end
  end

  delete '/tasks/:id/delete' do
    if logged_in?
      @tasks = Task.find_by_id(params[:id])
      @tasks.delete
      redirect to '/tasks'
    else
     redirect to '/login'
    end
  end

end
