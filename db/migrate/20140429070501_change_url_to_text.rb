class ChangeUrlToText < ActiveRecord::Migration
  def change
    change_column :offline_download_records, :url, :text
  end
end
