class Clients::HomeController < ApplicationController
  def index
    redirect_to new_client_session_path unless client_signed_in?
  end

  def current
    data = client_signed_in? ? current_client.as_json(only: [:email]) : {}

    render json: data
  end
end
