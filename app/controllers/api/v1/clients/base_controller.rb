class Api::V1::Clients::BaseController < Api::V1::BaseController
  def authentication_token
    super(Client)
  end
end