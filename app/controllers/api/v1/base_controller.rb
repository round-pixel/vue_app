class Api::V1::BaseController < ActionController::Base
  def auth
    render json: {status: 'ok'}
  end
end