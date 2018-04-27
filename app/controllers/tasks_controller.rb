class TasksController < ApplicationController

  get '/task'do
    if logged_in?
     @tasks = Task.all
     erb :'tasks/task'
   end
  end


end
