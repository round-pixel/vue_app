class Staffs::ClientsController < ApplicationController
  protect_from_forgery prepend: true

  def index
    render json: Client.all.as_json(only: [:id, :email, :full_name, :phone])
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render json: @client.as_json(only: [:id, :email, :full_name, :phone]), status: 201
    else
      render json: @client.errors.messages, status: 400
    end
  end

  private

  def client_params
    params.require(:client).permit(:email, :full_name, :phone)
  end
end
