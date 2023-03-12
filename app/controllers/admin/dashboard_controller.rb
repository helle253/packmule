module Admin
  class DashboardController < ApplicationController
    include Admin::Authentication

    before_action :redirect_if_not_authenticated

    def show
    end
  end
end
