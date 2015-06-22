class CreateTriggerUpdateAccountTotalSum < ActiveRecord::Migration
  def self.up
    execute <<-POSTGRESQL
      CREATE FUNCTION update_current_sum() RETURNS TRIGGER AS $update_account_total_sum$
        BEGIN
          IF NEW.type = 'доходи'::currency_transaction_type THEN
            UPDATE accounts SET current_sum = current_sum + NEW.sum WHERE id = NEW.account_id;
          ELSIF NEW.type = 'витрати'::currency_transaction_type THEN
            UPDATE accounts SET current_sum = current_sum - NEW.sum WHERE id = NEW.account_id;
          END IF;
          RETURN NULL;
        END ;
      $update_account_total_sum$ LANGUAGE plpgsql;
      CREATE TRIGGER update_account_total_sum
        AFTER INSERT ON currency_transactions
        FOR EACH ROW
        EXECUTE PROCEDURE update_current_sum();
    POSTGRESQL
  end
  def self.down
    execute <<-POSTGRESQL
      DROP TRIGGER update_account_total_sum ON currency_transactions;
      DROP FUNCTION update_current_sum();
    POSTGRESQL
  end
end
