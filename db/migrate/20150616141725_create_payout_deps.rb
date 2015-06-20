class CreatePayoutDeps < ActiveRecord::Migration
  def change
    create_table :payout_deps do |t|
      t.decimal :sum, precision: 6, scale: 2
      t.decimal :exchange_rate, precision: 5, scale: 4

      t.timestamps null: false
    end
  end
end
