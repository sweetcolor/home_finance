class AddForeignKeyToDebts < ActiveRecord::Migration
  def self.up
    remove_foreign_key :debts, column: :family_member_login
    remove_column :debts, :family_member_login
    remove_foreign_key :debts, :accounts
    remove_column :debts, :account_id

    add_column :debts, :give_loan_id, :integer
    add_column :debts, :borrow_debt_id, :integer
    add_foreign_key :debts, :accounts, column: :give_loan_id
    add_foreign_key :debts, :accounts, column: :borrow_debt_id
  end
end
