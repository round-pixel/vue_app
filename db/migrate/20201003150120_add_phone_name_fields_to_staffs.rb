class AddPhoneNameFieldsToStaffs < ActiveRecord::Migration[6.0]
  def change
    add_column :staffs, :phone, :string
    add_column :staffs, :full_name, :string
  end
end
