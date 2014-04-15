class AddInfosToOfflineDownloadRecords < ActiveRecord::Migration
  def change
    add_column :offline_download_records, :file_size, :string
    add_column :offline_download_records, :aver_speed, :string
    add_column :offline_download_records, :finished_at, :datetime
  end
end
