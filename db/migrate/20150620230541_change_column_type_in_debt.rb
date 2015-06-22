class ChangeColumnTypeInDebt < ActiveRecord::Migration
  def change
    execute <<-POSTGRESQL
      CREATE TYPE debt_type AS ENUM ('борг', 'позика');
      ALTER TABLE debts
        ALTER COLUMN type SET DATA TYPE debt_type USING type::debt_type;
    POSTGRESQL
  end
end
