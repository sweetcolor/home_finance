class CreateDatabase < ActiveRecord::Migration
  def change
    create_table :family_members, id: false do |t|
      t.primary_key :family_member_login, :string
      t.string :password
      t.string :password_digest
      t.string :remember_token
      t.string :name, limit: 30, null: false
      t.string :surname, limit: 30, null: false
      t.string :middle_name, limit: 30, null: false
      t.boolean :family_admin, null: false

      t.timestamps null: false
    end

    create_table :admins, id: false do |t|
      t.primary_key :admin_login, :string
      t.string :password
      t.string :password_digest
      t.string :remember_token
      t.string :email, null:false, limit: 30

      t.timestamps null: false
    end
    execute "ALTER TABLE admins ADD CONSTRAINT proper_email CHECK(email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')"

    create_table :families do |t|
      t.string :name, null: false, limit: 30

      t.timestamps null: false
    end

    create_table :accounts do |t|
      t.string :name, null: false, limit: 30
      t.decimal :current_sum, precision: 8, scale: 2

      t.timestamps null: false
    end

  end
end
