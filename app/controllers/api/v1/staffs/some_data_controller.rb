class Api::V1::Staffs::SomeDataController < Api::V1::Staffs::BaseController
  acts_as_token_authentication_handler_for Staff

  def index
    render json: [
        {
            id: 3,
            title: 'Sit'
        },
        {
            id: 4,
            title: 'Amet'
        }
    ]
  end
end