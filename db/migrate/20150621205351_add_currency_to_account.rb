class AddCurrencyToAccount < ActiveRecord::Migration
  def change
    remove_foreign_key :currency_transactions, :currencies
    remove_column :currency_transactions, :currency_id
    add_column :accounts, :currency_id, :integer
    add_foreign_key :accounts, :currencies
  end
end
