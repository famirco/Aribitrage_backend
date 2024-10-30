# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_10_30_130548) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "arbitrage_opportunities", force: :cascade do |t|
    t.decimal "buy_price"
    t.decimal "sell_price"
    t.decimal "profit"
    t.bigint "token_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_arbitrage_opportunities_on_token_id"
  end

  create_table "price_records", force: :cascade do |t|
    t.bigint "token_id", null: false
    t.decimal "price_usdc"
    t.decimal "gas_fee"
    t.string "rpc_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token_id"], name: "index_price_records_on_token_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.string "name"
    t.string "symbol"
    t.string "contract_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "arbitrage_opportunities", "tokens"
  add_foreign_key "price_records", "tokens"
end
