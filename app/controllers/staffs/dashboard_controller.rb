class Staffs::DashboardController < ApplicationController
  def index
    redirect_to new_staff_session_path unless staff_signed_in?
  end
end
