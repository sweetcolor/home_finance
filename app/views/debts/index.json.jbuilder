json.array!(@debts) do |debt|
  json.extract! debt, :id, :total_sum, :debt_date, :partial_repay_date, :full_repay_date, :status, :type
  json.url debt_url(debt, format: :json)
end
