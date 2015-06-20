class Currency < ActiveRecord::Base
  has_one :admin
  has_many :currency_transactions
  has_many :debts
  has_many :payout_debts
end
