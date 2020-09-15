class Api::V1::BaseController < ActionController::Base
  skip_before_action :verify_authenticity_token

  protected

    def authentication_token(model_name)
      user = model_name.find_by(email: params[:email])

      if user&.valid_password?(params[:password])
        render json: { token: user.authentication_token }
      else
        head(:unauthorized)
      end
    end
end