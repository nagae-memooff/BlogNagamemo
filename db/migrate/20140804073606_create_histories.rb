class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.float :total_price

      t.timestamps
    end
  end
end
