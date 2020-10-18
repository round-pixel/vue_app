class Staffs::OrganizationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_organization, only: [:update, :destroy, :update_client_organzations]

  def index
    json_conf = { only: [:id, :org_name, :org_type, :inn, :ogrn] }

    if params[:client_id] && params[:status] == 'created'
      render json: Organization.without_client(params[:client_id]).as_json(json_conf)
    else
      render json: Organization.all.as_json(json_conf)
    end
  end

  def create
    @organization = Organization.new(organization_params)

    add_clients

    if @organization.save
      render json: @organization.as_json(only: [:id, :org_name, :org_type, :inn, :ogrn]), status: 201
    else
      render json: @organization.errors.messages, status: 400
    end
  end

  def update
    @organization.update_attributes(organization_params)

    update_client_organzations

    render json: @organization.as_json(only: [:id, :org_name, :org_type, :inn, :ogrn]), status: 201
  end

  def destroy
    @organization.destroy

    head :no_content
  end

  private
    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:id, :org_name, :org_type, :inn, :ogrn)
    end

    def add_clients
      @organization.clients << Client.where(id: params[:clients].map {|org| org[:id] })
    end

    def update_client_organzations
      new_clients = params[:clients].map {|client| client[:id]}
      old_clients = @organization.client_organizations.pluck(:client_id)

      @organization.client_organizations.where(client_id: old_clients - new_clients).destroy_all

      (new_clients - old_clients).each do |new_client|
        ClientOrganization.create(organization: @organization, client_id: new_client)
      end
    end
end
