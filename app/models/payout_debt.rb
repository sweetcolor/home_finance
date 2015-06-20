class PayoutDebt < ActiveRecord::Base
  belongs_to :currency
  belongs_to :debt
end
