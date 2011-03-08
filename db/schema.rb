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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110308010304) do

  create_table "image_urls", :force => true do |t|
    t.string   "url"
    t.string   "color_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "view"
    t.string   "size"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.string   "default_caption"
    t.string   "url"
    t.integer  "store_id"
    t.string   "cafepress_product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cafepress_design_id"
    t.string   "cafepress_back_design_id"
    t.string   "gender"
    t.string   "cafepress_merchandise_id"
    t.string   "default_color_id"
    t.string   "default_cafepress_size_id"
  end

  create_table "sizes", :force => true do |t|
    t.integer  "product_id"
    t.string   "cafepress_size_id"
    t.string   "full_name"
    t.string   "display_sell_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stores", :force => true do |t|
    t.string   "cafepress_store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "cafepress_design_url"
    t.string   "design_background_color",   :default => "FFFFFF"
    t.string   "cafepress_back_design_url"
    t.string   "title"
  end

  create_table "user_tokens", :force => true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
