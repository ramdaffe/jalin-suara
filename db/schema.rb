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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130902142436) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.decimal  "latitude",                          :precision => 11, :scale => 8
    t.decimal  "longitude",                         :precision => 11, :scale => 8
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.boolean  "gmaps"
    t.text     "description"
    t.integer  "project_length"
    t.integer  "project_area"
    t.integer  "project_quantity"
    t.integer  "blm_amount",           :limit => 8
    t.integer  "self_fund_amount",     :limit => 8
    t.integer  "male_proposal"
    t.integer  "female_proposal"
    t.integer  "male_beneficiary"
    t.integer  "female_beneficiary"
    t.integer  "poor_beneficiary"
    t.integer  "subdistrict_id"
    t.integer  "category_id"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "comments", :force => true do |t|
    t.integer  "owner_id",         :null => false
    t.integer  "commentable_id",   :null => false
    t.string   "commentable_type", :null => false
    t.text     "body",             :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "guest_name"
    t.string   "guest_email"
  end

  create_table "districts", :force => true do |t|
    t.string   "name"
    t.integer  "province_id"
    t.decimal  "latitude",    :precision => 11, :scale => 8
    t.decimal  "longitude",   :precision => 11, :scale => 8
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "excel_files", :force => true do |t|
    t.string   "name"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "implementer_units", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "facilitator"
    t.string   "facilitator_phone"
    t.string   "call_center"
    t.integer  "subdistrict_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "posts", :force => true do |t|
    t.text     "description"
    t.integer  "activity_id"
    t.integer  "user_id"
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "title"
    t.decimal  "latitude",                          :precision => 11, :scale => 8
    t.decimal  "longitude",                         :precision => 11, :scale => 8
    t.boolean  "gmaps"
    t.integer  "budget",               :limit => 8
    t.integer  "dimension"
    t.integer  "beneficiary"
    t.integer  "postable_id"
    t.string   "postable_type"
    t.integer  "status"
  end

  create_table "provinces", :force => true do |t|
    t.string   "name"
    t.decimal  "latitude",   :precision => 11, :scale => 8
    t.decimal  "longitude",  :precision => 11, :scale => 8
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "services", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "uname"
    t.string   "uemail"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subdistricts", :force => true do |t|
    t.string   "name"
    t.integer  "district_id"
    t.decimal  "latitude",    :precision => 11, :scale => 8
    t.decimal  "longitude",   :precision => 11, :scale => 8
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
