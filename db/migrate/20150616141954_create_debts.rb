class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.decimal :total_sum, precision: 6, scale: 2
      t.date :debt_date
      t.date :partial_repay_date
      t.date :full_repay_date
      t.boolean :status
      t.string :type

      t.timestamps null: false
    end
  end
end
