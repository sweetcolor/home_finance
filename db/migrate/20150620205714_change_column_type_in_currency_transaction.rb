class ChangeColumnTypeInCurrencyTransaction < ActiveRecord::Migration
  def change
    execute <<-POSTGRESQL
      CREATE TYPE currency_transaction_type AS ENUM ('доходи', 'витрати');
      ALTER TABLE currency_transactions
        ALTER COLUMN type SET DATA TYPE currency_transaction_type USING type::currency_transaction_type;
    POSTGRESQL
  end
end
