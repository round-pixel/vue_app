class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.references :organization
      t.string :name
      t.string :type
      t.string :serial_number

      t.timestamps
    end
  end
end
