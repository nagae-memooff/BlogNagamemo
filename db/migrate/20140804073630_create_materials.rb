class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.string :type
      t.string :buy_unit
      t.float :buy_price
      t.string :cook_unit
      t.float :cook_count
      t.float :cook_price
      t.float :now

      t.timestamps
    end
  end
end
