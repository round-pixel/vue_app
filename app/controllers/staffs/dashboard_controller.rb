class Staffs::DashboardController < ApplicationController
  def index
    redirect_to new_staff_session_path unless staff_signed_in?
  end

  def current
    data = staff_signed_in? ? current_staff.as_json(only: [:email]) : {}

    render json: data
  end
end
