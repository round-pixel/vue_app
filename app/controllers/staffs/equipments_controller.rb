class Staffs::EquipmentsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_equipment, only: [:show, :update, :destroy]

  def index
    json_conf = { only: [:id, :name, :type, :serial_number] }

    render json: Equipment.all.as_json(json_conf)
  end

  def show
    render json: @equipment.as_json(
        only: [:id, :name, :type, :serial_number],
        include: :organization
    )
  end

  def create
    @equipment = Equipment.new(equipment_params)

    if @equipment.save
      render json: @equipment.as_json(only: [:id, :name, :type, :serial_number]), status: 201
    else
      render json: @equipment.errors.messages, status: 400
    end
  end

  def update
    @equipment.update_attributes(equipment_params)

    render json: @equipment.as_json(only: [:id, :name, :type, :serial_number]), status: 201
  end

  def destroy
    @equipment.destroy

    head :no_content
  end

  private
  def set_equipment
    @equipment = Equipment.find(params[:id])
  end

  def equipment_params
    params.require(:equipment).permit(:id, :name, :type, :serial_number, :organization_id)
  end
end
