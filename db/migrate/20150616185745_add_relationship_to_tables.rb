class AddRelationshipToTables < ActiveRecord::Migration
  def change
    rename_table :payout_deps, :payout_debts
    add_column :currency_transactions, :category_id, :integer
    add_column :currency_transactions, :account_id, :integer
    add_column :currency_transactions, :currency_id, :integer

    add_column :debts, :account_id, :integer
    add_column :debts, :currency_id, :integer
    add_column :debts, :family_member_login, :string

    add_column :payout_debts, :debt_id, :integer
    add_column :payout_debts, :currency_id, :integer

    add_column :currencies, :admin_login, :string

    add_column :accounts, :family_member_login, :string

    add_column :family_members, :family_id, :integer

    add_foreign_key :currency_transactions, :categories
    add_foreign_key :currency_transactions, :accounts
    add_foreign_key :currency_transactions, :currencies

    add_foreign_key :debts, :accounts
    add_foreign_key :debts, :currencies
    add_foreign_key :debts, :family_members, column: :family_member_login, primary_key: :family_member_login

    add_foreign_key :payout_debts, :debts
    add_foreign_key :payout_debts, :currencies

    add_foreign_key :currencies, :admins, column: :admin_login, primary_key: :admin_login

    add_foreign_key :accounts, :family_members, column: :family_member_login, primary_key: :family_member_login

    add_foreign_key :family_members, :families
  end
end
