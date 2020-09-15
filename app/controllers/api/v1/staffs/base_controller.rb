class Api::V1::Staffs::BaseController < Api::V1::BaseController
  def authentication_token
    super(Staff)
  end
end