class CreatePreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :preferences do |t|
      t.belongs_to :preferrer, polymorphic: true, null: true
      t.belongs_to :preferable, polymorphic: true, null: true

      t.timestamps
    end
  end
end
