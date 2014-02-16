class CreateFileRecords < ActiveRecord::Migration
  def change
    create_table :file_records do |t|
      t.string :file_name
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
