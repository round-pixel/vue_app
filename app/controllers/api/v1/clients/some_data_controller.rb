class Api::V1::Clients::SomeDataController < Api::V1::Clients::BaseController
  acts_as_token_authentication_handler_for Client

  def index
    render json: [
        {
            id: 1,
            title: 'Lorem'
        },
        {
            id: 2,
            title: 'Ipsum'
        }
    ]
  end
end