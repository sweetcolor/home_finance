json.array!(@currency_transactions) do |currency_transaction|
  json.extract! currency_transaction, :id, :date, :sum, :description, :type
  json.url currency_transaction_url(currency_transaction, format: :json)
end
