class CreateViewCounts < ActiveRecord::Migration
  def change
    create_table :view_counts do |t|
      t.integer :count, default: 0

      t.timestamps
    end
  end
end
