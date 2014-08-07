class CreateHisMats < ActiveRecord::Migration
  def change
    create_table :his_mats do |t|
      t.integer :history_id
      t.integer :material_id

      t.timestamps
    end
  end
end
