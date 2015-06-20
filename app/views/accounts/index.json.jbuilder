json.array!(@accounts) do |account|
  json.extract! account, :id, :current_sum
  json.url account_url(account, format: :json)
end
