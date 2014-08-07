json.array!(@histories) do |history|
  json.extract! history, :id, :total_price
  json.url history_url(history, format: :json)
end
