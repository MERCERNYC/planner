require_relative './config/environment'

use Rack::MethodOverride
use UsersController
use TasksController
run ApplicationController
