json.array!(@file_records) do |file_record|
  json.extract! file_record, :id
  json.url file_record_url(file_record, format: :json)
end
