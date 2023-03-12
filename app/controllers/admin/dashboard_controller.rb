module Admin
  class DashboardController < ApplicationController
    redirect_if_not_admin_authenticated

    def show
    end
  end
end
