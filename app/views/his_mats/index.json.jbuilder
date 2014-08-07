json.array!(@his_mats) do |his_mat|
  json.extract! his_mat, :id, :history_id, :material_id
  json.url his_mat_url(his_mat, format: :json)
end
