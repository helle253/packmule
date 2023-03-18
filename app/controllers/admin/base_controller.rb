module Admin
  class BaseController < ApplicationController
    layout 'admin'
    include Admin::Authentication
    before_action :redirect_if_not_authenticated
  end
end
