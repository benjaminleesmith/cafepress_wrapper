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

ActiveRecord::Schema.define(:version => 20110305004402) do

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
  end

  create_table "stores", :force => true do |t|
    t.string   "cafepress_store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "cafepress_design_url"
    t.string   "design_background_color",   :default => "FFFFFF"
    t.string   "cafepress_back_design_url"
  end

  create_table "user_tokens", :force => true do |t|
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
