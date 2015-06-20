class CreateCurrencyTransactions < ActiveRecord::Migration
  def change
    create_table :currency_transactions do |t|
      t.date :date, null: false
      t.decimal :sum, precision: 6, scale: 2, null: false
      t.text :description
      t.string :type, null: false
    end
  end
end
