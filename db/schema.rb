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

ActiveRecord::Schema.define(:version => 20140103170721) do

  create_table "datalines", :force => true do |t|
    t.text     "tsv_string"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "infile_id"
    t.integer  "file_order"
  end

  create_table "infiles", :force => true do |t|
    t.string   "file_name"
    t.string   "parse_method"
    t.integer  "file_size"
    t.text     "first_line"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "peptide_column"
  end

  create_table "peptide_proteins", :force => true do |t|
    t.integer  "peptide_id"
    t.integer  "protein_id"
    t.integer  "protein_mod_site"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "peptide_proteins", ["peptide_id"], :name => "index_peptide_proteins_on_peptide_id"
  add_index "peptide_proteins", ["protein_id"], :name => "index_peptide_proteins_on_protein_id"

  create_table "peptides", :force => true do |t|
    t.string   "aseq"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "mod_loc"
    t.integer  "nth"
    t.boolean  "searched"
    t.integer  "dataline_id"
  end

  add_index "peptides", ["dataline_id"], :name => "index_peptides_on_dataline_id"

  create_table "proteins", :force => true do |t|
    t.string   "sp_or_tr"
    t.string   "accession"
    t.string   "description"
    t.text     "aa_sequence"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 8
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
