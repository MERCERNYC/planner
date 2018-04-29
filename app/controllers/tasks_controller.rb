class TasksController < ApplicationController

  get '/tasks'do
     @tasks = Task.all
     erb :'tasks/index'
   end
  end

  get '/tasks/new' do
     if !logged_in?
      redirect to '/login'
     else
       erb :'tasks/new'
     end
   end

   get '/tasks/:id' do
     @tasks = Task.find(params[:id])
     if logged_in?
       erb :"tasks/show"
     else
       redirect '/login'
     end
   end

   get '/tasks/:id/edit' do
      if !logged_in?
        redirect to '/login'
      else
       if  @tasks = current_user.tasks.find_by(params[:id])
        erb :"tasks/edit"
      else
        redirect to '/tasks'
       end
    end

   post '/tasks' do
     if logged_in? && params[:name].empty?
       redirect '/tasks/create'
     else
       @tasks = Task.create(name: params[:name])
       redirect "/tasks/#{@tasks.id}"
      end
    end


  patch '/task/:id' do
    if logged_in? && params[:name] == ""
      redirect to "/task/#{params[:id]}/edit"
    else
      @task = Task.find_by_id(params[:id])
      if @task && @task.user == current_user
        @task.update(name: params[:name])
        redirect to "/task/#{@task.id}"
      else
        redirect to "/task/#{@task.id}/edit"
      end
    end
  end
#
#   delete '/task/:id/delete' do
#     if logged_in?
#       @task = Task.find_by_id(params[:id])
#     if @task && @task.user == current_user
#       @task.delete
#     end
#     redirect to '/task'
#     else
#     redirect to '/login'
#   end
# end
# end
#

end
