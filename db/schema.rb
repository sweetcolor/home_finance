# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150616185745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "name",                limit: 30,                         null: false
    t.decimal  "current_sum",                    precision: 8, scale: 2
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "family_member_login"
  end

  create_table "admins", primary_key: "admin_login", force: :cascade do |t|
    t.string   "password"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "email",           limit: 30, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",               limit: 30, null: false
    t.integer  "parent_category_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "admin_login"
  end

  create_table "currency_transactions", force: :cascade do |t|
    t.date    "date",                                null: false
    t.decimal "sum",         precision: 6, scale: 2, null: false
    t.text    "description"
    t.string  "type",                                null: false
    t.integer "category_id"
    t.integer "account_id"
    t.integer "currency_id"
  end

  create_table "debts", force: :cascade do |t|
    t.decimal  "total_sum",           precision: 6, scale: 2
    t.date     "debt_date"
    t.date     "partial_repay_date"
    t.date     "full_repay_date"
    t.boolean  "status"
    t.string   "type"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "account_id"
    t.integer  "currency_id"
    t.string   "family_member_login"
  end

  create_table "families", force: :cascade do |t|
    t.string   "name",       limit: 30, null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "family_members", primary_key: "family_member_login", force: :cascade do |t|
    t.string   "password"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "name",            limit: 30, null: false
    t.string   "surname",         limit: 30, null: false
    t.string   "middle_name",     limit: 30, null: false
    t.boolean  "family_admin",               null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "family_id"
  end

  create_table "payout_debts", force: :cascade do |t|
    t.decimal  "sum",           precision: 6, scale: 2
    t.decimal  "exchange_rate", precision: 5, scale: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "debt_id"
    t.integer  "currency_id"
  end

  add_foreign_key "accounts", "family_members", column: "family_member_login", primary_key: "family_member_login"
  add_foreign_key "categories", "categories", column: "parent_category_id"
  add_foreign_key "currencies", "admins", column: "admin_login", primary_key: "admin_login"
  add_foreign_key "currency_transactions", "accounts"
  add_foreign_key "currency_transactions", "categories"
  add_foreign_key "currency_transactions", "currencies"
  add_foreign_key "debts", "accounts"
  add_foreign_key "debts", "currencies"
  add_foreign_key "debts", "family_members", column: "family_member_login", primary_key: "family_member_login"
  add_foreign_key "family_members", "families"
  add_foreign_key "payout_debts", "currencies"
  add_foreign_key "payout_debts", "debts"
end
