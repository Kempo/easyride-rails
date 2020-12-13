class CreateDrivers < ActiveRecord::Migration[6.1]
  def change
    create_table :drivers do |t|
      t.string :name, null: true
      t.string :address, null: true
      t.integer :total_space, default: 0

      t.timestamps
    end
  end
end
