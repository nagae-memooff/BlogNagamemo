class CreateViewerLogs < ActiveRecord::Migration
  def change
    create_table :viewer_logs do |t|
      t.integer :view_type, default: 0
      t.integer :post_id
      t.integer :login_type, default: 0
      t.integer :user_id
      t.string :user_ip

      t.timestamps
    end
  end
end
