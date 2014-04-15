class CreateOfflineDownloadRecords < ActiveRecord::Migration
  def change
    create_table :offline_download_records do |t|
      t.string :url
      t.string :file_name
      t.integer :retry_times, default: 5
      t.integer :user_id
      t.integer :status_code, default: 0

      t.timestamps
    end
  end
end
