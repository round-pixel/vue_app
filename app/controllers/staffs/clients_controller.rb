class Staffs::ClientsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_client, only: [:update, :destroy, :update_client_organzations]

  def index
    render json: Client.all.as_json(only: [:id, :email, :full_name, :phone])
  end

  def create
    @client = Client.new(client_params)

    add_organizations

    if @client.save
      render json: @client.as_json(only: [:id, :email, :full_name, :phone]), status: 201
    else
      render json: @client.errors.messages, status: 400
    end
  end


  def update
    @client.update_attributes(client_params)

    update_client_organzations

    render json: @client.as_json(
        only: [:id, :full_name, :email, :phone],
        include: :organizations
        ), status: 201
  end

  def destroy
    @client.destroy

    head :no_content
  end

  private

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:email, :full_name, :phone)
    end

    def add_organizations
      @client.organizations << Organization.where(id: params[:organizations].map {|org| org[:id] })
    end

    def update_client_organzations
      new_organizations = params[:organizations].map {|org| org[:id]}
      old_organizations = @client.client_organizations.pluck(:organization_id)

      @client.client_organizations.where(organization_id: old_organizations - new_organizations).destroy_all

      (new_organizations - old_organizations).each do |new_org|
        ClientOrganization.create(client: @client, organization_id: new_org)
      end
    end
end
