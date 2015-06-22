class CreateTriggerUpdateAccountCurrentSumAfterDebt < ActiveRecord::Migration
  def self.up
    execute <<-POSTGRESQL
      CREATE FUNCTION update_after_insert_debt() RETURNS TRIGGER AS $update_account_total_sum$
        BEGIN
          IF NEW.type = 'борг'::debt_type THEN
            UPDATE accounts SET current_sum = current_sum + NEW.total_sum WHERE id = NEW.account_id;
          ELSIF NEW.type = 'позика'::debt_type THEN
            UPDATE accounts SET current_sum = current_sum - NEW.total_sum WHERE id = NEW.account_id;
          END IF;
          RETURN NULL;
        END ;
      $update_account_total_sum$ LANGUAGE plpgsql;
      CREATE TRIGGER update_current_sum_after_insert_debt
      AFTER INSERT ON debts
      FOR EACH ROW
      EXECUTE PROCEDURE update_after_insert_debt();
    POSTGRESQL
  end
  def self.down
    execute <<-POSTGRESQL
      DROP TRIGGER update_current_sum_after_insert_debt ON debts;
      DROP FUNCTION update_after_insert_debt();
    POSTGRESQL
  end
end
