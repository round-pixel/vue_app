class Clients::HomeController < ApplicationController
  def index
    redirect_to new_client_session_path unless client_signed_in?
  end
end
