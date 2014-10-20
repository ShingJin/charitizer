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

ActiveRecord::Schema.define(version: 20141020092942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rules", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "product_ids",                    array: true
    t.string   "collection_ids",                 array: true
    t.string   "tag_ids",                        array: true
    t.boolean  "by_percentage"
    t.integer  "per_product"
    t.integer  "per_order"
    t.integer  "raised"
    t.string   "timeframe"
    t.integer  "amount_due"
    t.boolean  "paid",           default: false
    t.datetime "starting_date"
    t.datetime "ending_date"
    t.string   "tags",                           array: true
    t.string   "identifier"
    t.integer  "frequency"
    t.integer  "shop_id"
    t.string   "domain"
  end

  create_table "shops", force: true do |t|
    t.string   "domain"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "frequency"
  end

end
