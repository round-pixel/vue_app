class Api::V1::Staffs::SomeDataController < Api::V1::BaseController
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