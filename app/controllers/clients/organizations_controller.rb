class Clients::OrganizationsController < ApplicationController
  def index
    render json: current_client.organizations
  end
end
