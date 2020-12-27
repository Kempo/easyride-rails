class UpdateRidersCounterCache < ActiveRecord::Migration[6.1]
  def change
    add_column :cars, :riders_count, :integer, default: 0
    remove_column :drivers, :riders_count, :integer, default: 0
  end
end
