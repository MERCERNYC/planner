require './config/environment' #tux worked after I used required 

use Rack::MethodOverride
use UsersController
use TasksController
run ApplicationController
