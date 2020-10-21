# frozen_string_literal: true

class Clients::PasswordsController < Devise::PasswordsController
  skip_before_action :verify_authenticity_token

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end
  def update
    @client = Client.find_by(id: params[:client_id])

    if @client
      @client.password = params[:password]
      @client.password_confirmation = params[:password_confirmation]

      if @client.save
        render json: { status: 200 }
      else
        render json: { status: 400 }
      end
    else
      head :no_content
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
end
