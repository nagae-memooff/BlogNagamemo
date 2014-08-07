class AddDefaultValueToTotalPrice < ActiveRecord::Migration
  def change
    change_column :histories, :total_price, :float, default: 0
  end
end
