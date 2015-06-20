class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false, limit: 30
      t.integer :parent_category_id

      t.timestamps null: false
    end
      add_foreign_key :categories, :categories, column: :parent_category_id
  end
end
