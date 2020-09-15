class Api::V1::Clients::SomeDataController < Api::V1::BaseController
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