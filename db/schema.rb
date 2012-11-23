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

ActiveRecord::Schema.define(:version => 20121123160850) do

  create_table "authentications", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentications", ["user_id"], :name => "index_authentications_on_user_id"

  create_table "direct_messages", :force => true do |t|
    t.text     "body"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "direct_messages", ["recipient_id"], :name => "index_direct_messages_on_recipient_id"
  add_index "direct_messages", ["sender_id"], :name => "index_direct_messages_on_sender_id"

  create_table "discussion_messages", :force => true do |t|
    t.text     "body"
    t.integer  "discussion_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "discussion_messages", ["discussion_id"], :name => "index_discussion_messages_on_discussion_id"
  add_index "discussion_messages", ["user_id"], :name => "index_discussion_messages_on_user_id"

  create_table "discussions", :force => true do |t|
    t.string   "title"
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "discussions", ["group_id"], :name => "index_discussions_on_group_id"
  add_index "discussions", ["user_id"], :name => "index_discussions_on_user_id"

  create_table "entries", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "entries", ["event_id"], :name => "index_entries_on_event_id"
  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "event_messages", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_messages", ["event_id"], :name => "index_event_messages_on_event_id"
  add_index "event_messages", ["user_id"], :name => "index_event_messages_on_user_id"

  create_table "events", :force => true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "title"
    t.boolean  "all_day"
    t.text     "description"
    t.boolean  "milestone"
    t.integer  "organizer"
    t.integer  "group_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "sport_id"
  end

  add_index "events", ["group_id"], :name => "index_events_on_group_id"

  create_table "group_admins", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "group_admins", ["group_id"], :name => "index_group_admins_on_group_id"
  add_index "group_admins", ["user_id"], :name => "index_group_admins_on_user_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "public"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "groups_sports", :id => false, :force => true do |t|
    t.integer "sport_id"
    t.integer "group_id"
  end

  add_index "groups_sports", ["group_id"], :name => "index_groups_sports_on_group_id"
  add_index "groups_sports", ["sport_id"], :name => "index_groups_sports_on_sport_id"

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "group_id"
  end

  add_index "groups_users", ["group_id"], :name => "index_groups_users_on_group_id"
  add_index "groups_users", ["user_id"], :name => "index_groups_users_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "link"
  end

  create_table "user_invitations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "inviter_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                :default => "", :null => false
    t.string   "encrypted_password",                   :default => ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token",       :limit => 60
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "locale"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["invitation_token"], :name => "index_users_on_invitation_token"
  add_index "users", ["invited_by_id"], :name => "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "workout_tips", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.date     "tip_date"
    t.string   "author"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
