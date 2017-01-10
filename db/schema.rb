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

ActiveRecord::Schema.define(version: 20170109231627) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "developers", force: :cascade do |t|
    t.string   "name"
    t.string   "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "developerskills", force: :cascade do |t|
    t.integer  "developer_id"
    t.integer  "skill_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["developer_id"], name: "index_developerskills_on_developer_id", using: :btree
    t.index ["skill_id"], name: "index_developerskills_on_skill_id", using: :btree
  end

  create_table "managers", force: :cascade do |t|
    t.string   "name"
    t.string   "last"
    t.string   "email"
    t.string   "company"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "deadline"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "manager_id"
    t.index ["manager_id"], name: "index_projects_on_manager_id", using: :btree
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.string   "level"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.string   "cost"
    t.string   "status"
    t.integer  "priority_level"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "project_id"
    t.index ["project_id"], name: "index_tasks_on_project_id", using: :btree
  end

  create_table "taskskills", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "task_id"
    t.integer  "skill_id"
    t.index ["skill_id"], name: "index_taskskills_on_skill_id", using: :btree
    t.index ["task_id"], name: "index_taskskills_on_task_id", using: :btree
  end

  add_foreign_key "projects", "managers"
  add_foreign_key "tasks", "projects"
end
