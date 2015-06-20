class Category < ActiveRecord::Base
  # has_one :user
  has_many :currency_transactions
end
