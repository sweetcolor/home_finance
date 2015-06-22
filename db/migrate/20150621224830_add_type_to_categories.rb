class AddTypeToCategories < ActiveRecord::Migration
  def change
    execute <<-POSTGRESQL
      CREATE TYPE category_type AS ENUM ('доходи', 'витрати');
      ALTER TABLE categories
        ADD COLUMN type category_type;
    POSTGRESQL
  end
end
