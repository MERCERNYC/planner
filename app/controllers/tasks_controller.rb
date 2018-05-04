class TasksController < ApplicationController

  get '/tasks'do
    if logged_in?
      @tasks = current_user.tasks
      erb :'tasks/index'
    else
      redirect to '/signup'
   end
  end

  get '/tasks/new' do
    if logged_in?
      erb :'tasks/create'
    else
      redirect to '/login'
    end
  end

  get '/tasks/:id' do
    if logged_in?
      @task = Task.find_by(:id => params[:id])
      erb :"tasks/show"
    else
      redirect '/login'
    end
  end


  post '/tasks' do
    if logged_in?
      @task = current_user.tasks.create(:name => params[:name])
      flash[:notice] = "Your Task Has Been Succesfully Created"
      redirect "/tasks"
    else
      erb '/tasks/create'
    end
  end

  get '/tasks/:id/edit' do
    if logged_in?
      @task = Task.find_by(:id => params[:id])
      if current_user.id == @task.user_id
      erb :"tasks/edit"
    else
      flash[:notice] = "You are not authorized to edit this task."
      redirect to '/login'
     end
    end
  end

  patch '/tasks/:id' do
    if logged_in?
      @task = Task.find_by(:id => params[:id])
      @task.name = params[:name]
      if @task.save
        flash[:notice] = "Your Task Has Been Succesfully Updated"
        redirect to '/tasks'
      else
        redirect to "/tasks/#{@task.id}/edit"
      end
    end
  end

  delete '/tasks/:id/delete' do
    if logged_in?
      @task = Task.find_by(:id => params[:id])
      if current_user.id == @task.user_id
      @task.delete
      flash[:notice] = "Task successfully removed!"
      redirect to '/tasks'
      else
      redirect to '/login'
      end
    end
  end

end
