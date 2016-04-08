json.array!(@posts) do |post|
  json.extract! post, :id, :belongs_to, :ID, :type, :author, :date, :title, :content, :excerpt, :status, :name
  json.url post_url(post, format: :json)
end
