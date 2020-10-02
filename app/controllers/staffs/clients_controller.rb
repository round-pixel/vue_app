class Staffs::ClientsController < ApplicationController
  protect_from_forgery prepend: true

  before_action :set_client, only: [:update, :destroy]

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


  def update
    @client.update_attributes(client_params)

    render json: @client.as_json(only: [:id, :full_name, :email, :phone]), status: 201
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
end
