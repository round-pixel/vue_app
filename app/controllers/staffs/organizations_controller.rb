class Staffs::OrganizationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_organization, only: [:update, :destroy]

  def index
    render json: Organization.all.as_json(only: [:id, :org_name, :org_type, :inn, :ogrn])
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: @organization.as_json(only: [:id, :org_name, :org_type, :inn, :ogrn]), status: 201
    else
      render json: @organization.errors.messages, status: 400
    end
  end

  def update
    @organization.update_attributes(organization_params)

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
end
