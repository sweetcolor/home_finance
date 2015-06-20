json.array!(@payout_debts) do |payout_debt|
  json.extract! payout_debt, :id, :sum, :exchange_rate
  json.url payout_dep_url(payout_debt, format: :json)
end
