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

ActiveRecord::Schema.define(version: 20160831100414) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_histories", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "amount",           default: "0"
    t.string   "transaction_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["id"], name: "index_account_histories_on_id", using: :btree
  end

  create_table "account_types", force: :cascade do |t|
    t.string   "name",       default: ""
    t.boolean  "is_active",  default: true
    t.string   "features",   default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "accounts", force: :cascade do |t|
    t.string  "fund",        default: "0"
    t.boolean "is_active",   default: true
    t.boolean "is_archived", default: false
    t.integer "client_id"
    t.index ["id"], name: "index_accounts_on_id", using: :btree
  end

  create_table "admins", force: :cascade do |t|
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  create_table "apps", force: :cascade do |t|
    t.string   "name",       default: ""
    t.string   "app_uid",    default: ""
    t.integer  "client_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "first_name",      default: ""
    t.string   "last_name",       default: ""
    t.string   "company",         default: ""
    t.boolean  "is_active",       default: true
    t.string   "password"
    t.boolean  "is_archived",     default: false
    t.string   "callbackurl",     default: ""
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
  end

  create_table "customers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password"
    t.boolean  "is_active",       default: true
    t.boolean  "is_archive",      default: false
    t.string   "telephone"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "pin_code"
    t.integer  "client_id"
    t.string   "username"
    t.boolean  "random_selected", default: false
    t.boolean  "is_verified",     default: false
    t.string   "pay_token",       default: ""
    t.index ["id"], name: "index_customers_on_id", using: :btree
  end

  create_table "employees", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "telephone"
    t.boolean  "is_active",       default: true
    t.boolean  "is_archive",      default: false
    t.integer  "client_id"
    t.integer  "privilege_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_employees_on_email", using: :btree
    t.index ["id"], name: "index_employees_on_id", using: :btree
    t.index ["telephone"], name: "index_employees_on_telephone", using: :btree
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "owner_id"
    t.string   "owner_type"
    t.index ["owner_id", "owner_type"], name: "index_oauth_applications_on_owner_id_and_owner_type", using: :btree
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "parents", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "parent_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "parentships", force: :cascade do |t|
    t.integer  "customer_id"
    t.integer  "child_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "privileges", force: :cascade do |t|
    t.string   "name"
    t.string   "keys"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_privileges_on_id", using: :btree
  end

  create_table "references", force: :cascade do |t|
    t.string   "value",       default: ""
    t.integer  "customer_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["id"], name: "index_references_on_id", using: :btree
  end

  create_table "registered_devices", force: :cascade do |t|
    t.string   "gcm_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "customer_id"
  end

  create_table "services", force: :cascade do |t|
    t.string   "name",        default: ""
    t.boolean  "is_active",   default: true
    t.string   "description", default: ""
    t.string   "code",        default: ""
    t.string   "serverurl",   default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["id"], name: "index_services_on_id", using: :btree
  end

  create_table "tests", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "customer_id"
    t.integer  "employee_id"
    t.string   "token",       default: ""
    t.datetime "expires_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "amount",      default: "0"
    t.string   "is_archived", default: "f"
    t.string   "remarks"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "reference",   default: ""
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
