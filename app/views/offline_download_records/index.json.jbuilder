json.array!(@offline_download_records) do |offline_download_record|
  json.extract! offline_download_record, :id, :url, :file_name, :retry_times, :user_id, :status
  json.url offline_download_record_url(offline_download_record, format: :json)
end
