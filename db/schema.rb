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

ActiveRecord::Schema.define(version: 20151211201640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string   "body"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "application_forms", force: :cascade do |t|
    t.string   "name",            null: false
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "breeds", force: :cascade do |t|
    t.string  "name",   null: false
    t.integer "pet_id"
  end

  create_table "organization_memberships", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "can_view_all_applications",   default: false
    t.boolean  "can_edit_all_applications",   default: false
    t.boolean  "can_delete_all_applications", default: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "city",            null: false
    t.string   "state_province",  null: false
    t.string   "country",         null: false
    t.string   "phone_number"
    t.string   "phone_extension"
    t.string   "email_address"
    t.string   "website"
    t.boolean  "phone_preferred"
  end

  create_table "pet_applications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "pet_id"
    t.integer  "organization_id"
    t.integer  "application_type"
    t.integer  "status",           default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string   "animal"
    t.boolean  "is_mix?"
    t.string   "age"
    t.string   "name"
    t.string   "size"
    t.string   "sex"
    t.string   "description"
    t.boolean  "good_with_dogs"
    t.boolean  "good_with_cats"
    t.boolean  "good_with_kids"
    t.boolean  "is_fosterable",           default: false, null: false
    t.boolean  "is_adoptable",            default: false, null: false
    t.integer  "status"
    t.integer  "organization_id"
    t.integer  "adoption_application_id"
    t.integer  "foster_application_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "body",                                null: false
    t.integer  "application_form_id"
    t.integer  "pet_application_id"
    t.boolean  "is_required",         default: false, null: false
    t.integer  "input_type"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "position",            default: 1
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree

end
