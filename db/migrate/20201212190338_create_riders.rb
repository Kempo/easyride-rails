class CreateRiders < ActiveRecord::Migration[6.1]
  def change
    create_table :riders do |t|
      t.string :name, null: true
      t.string :address, null: true

      t.belongs_to :car, null: true, foreign_key: true

      t.timestamps
    end
  end
end
