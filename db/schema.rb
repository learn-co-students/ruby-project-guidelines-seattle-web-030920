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

ActiveRecord::Schema.define(version: 8) do

  create_table "bank_accounts", force: :cascade do |t|
    t.integer "account_number"
    t.string "iban"
    t.string "name"
    t.string "rounting_number"
    t.string "swift_bic"
    t.float "account_balance"
  end

  create_table "portfolios", force: :cascade do |t|
    t.integer "user_id"
    t.integer "stock_id"
    t.integer "quantity"
    t.float "equity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stock_ratings", force: :cascade do |t|
    t.integer "stock_id"
    t.integer "score"
    t.string "rating"
    t.string "recommendation"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "ticker"
    t.string "company_name"
    t.string "industry"
    t.string "exchange"
    t.float "current_price"
    t.float "revenue"
    t.float "ebitda"
    t.float "market_cap"
    t.float "gross_margin"
    t.float "ebitda_margin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trades", force: :cascade do |t|
    t.integer "user_id"
    t.integer "stock_id"
    t.integer "quantity"
    t.string "buy_or_sell"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_cash_holdings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "bank_account_id"
    t.float "cash"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "upgrade"
  end

end
