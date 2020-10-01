class Staffs::OrganizationsController < ApplicationController
  protect_from_forgery prepend: true

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

  private

  def organization_params
    params.require(:organization).permit(:org_name, :org_type, :inn, :ogrn)
  end
end
