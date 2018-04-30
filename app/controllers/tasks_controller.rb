
class TasksController < ApplicationController

#allows the view to access all the posts in the database through the instance variable @tasks
#index action
  get '/tasks'do #list all tasks
    @tasks = current_user.tasks
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

  get '/tasks/:id' do #show task
    if logged_in?
    @tasks = Task.find_by(:id => params[:id])
     erb :"tasks/show"
    else
      redirect '/login'
    end
  end

#create a new task
  post '/tasks' do
    if logged_in?
      @tasks = Task.create(:name => params[:name])
      redirect "/tasks"
    else
      erb '/tasks/create'
    end
  end

#show action
#load edit form
  get '/tasks/:id/edit' do
    if logged_in?
    @tasks = Task.find_by(:id => params[:id])
    if current_user.id == @tasks.user_id
    erb :"tasks/edit"
    else
     flash[:notice] = "You are not authorized to edit this task."
     redirect to '/login'
   end
   end
  end

#edit action
  patch '/tasks/:id' do
    if logged_in?
     @tasks = Task.find_by(:id => params[:id])
     @tasks.name = params[:name]
     if @tasks.save
     flash[:notice] = "Your Task Has Been Succesfully Updated"
     redirect to '/tasks'
    else
     redirect to "/tasks/#{@tasks.id}/edit"
   end
    end
  end

  delete '/tasks/:id/delete' do
    if logged_in?
     @tasks = Task.find_by(:id => params[:id])
    if current_user.id == @tasks.user_id
      @tasks.delete
      flash[:notice] = "Task successfully removed!"
      redirect to '/tasks'
    else
     redirect to '/login'
    end
  end

end
