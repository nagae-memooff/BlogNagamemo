json.array!(@materials) do |material|
  json.extract! material, :id, :name, :m_type, :buy_unit, :buy_price, :cook_unit, :cook_count, :cook_price, :now
  json.url material_url(material, format: :json)
end
