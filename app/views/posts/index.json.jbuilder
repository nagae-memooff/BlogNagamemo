json.array!(@posts) do |post|
  json.extract! post, :user_id, :content
  json.url post_url(post, format: :json)
end
