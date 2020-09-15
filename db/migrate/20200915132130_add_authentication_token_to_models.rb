class AddAuthenticationTokenToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :authentication_token, :string, limit: 30
    add_column :staffs, :authentication_token, :string, limit: 30

    add_index :clients, :authentication_token, unique: true
    add_index :staffs, :authentication_token, unique: true
  end
end
