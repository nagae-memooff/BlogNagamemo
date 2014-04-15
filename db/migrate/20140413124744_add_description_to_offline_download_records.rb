class AddDescriptionToOfflineDownloadRecords < ActiveRecord::Migration
  def change
    add_column :offline_download_records, :description, :string
  end
end
