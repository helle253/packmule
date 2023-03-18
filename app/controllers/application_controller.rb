class ApplicationController < ActionController::Base
  include Authentication
  include User::Authentication
end
