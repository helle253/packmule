module User
  class DashboardController < ApplicationController
    include User::Authentication

    before_action :redirect_if_not_authenticated

    def show
    end
  end
end
