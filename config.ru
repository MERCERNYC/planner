require_relative './config/environment'

use Rack::MethodOverride
use UsersController
use ListsController
use TasksController
run ApplicationController
