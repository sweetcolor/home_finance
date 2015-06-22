class FixProcedureUpdateAfterInsertDebt < ActiveRecord::Migration
  def change
    execute <<-POSTGRESQL
      DROP TRIGGER update_current_sum_after_insert_debt ON debts;
      DROP FUNCTION update_after_insert_debt();

      CREATE FUNCTION update_after_insert_debt() RETURNS TRIGGER AS $update_account_total_sum$
        BEGIN
          UPDATE accounts SET current_sum = current_sum + NEW.total_sum WHERE id = NEW.borrow_debt_id;
          UPDATE accounts SET current_sum = current_sum - NEW.total_sum WHERE id = NEW.give_loan_id;
          RETURN NULL;
        END ;
      $update_account_total_sum$ LANGUAGE plpgsql;

      CREATE TRIGGER update_current_sum_after_insert_debt
        AFTER INSERT ON debts
          FOR EACH ROW
            EXECUTE PROCEDURE update_after_insert_debt();
    POSTGRESQL
  end
end
