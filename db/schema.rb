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

ActiveRecord::Schema.define(version: 4) do

  create_table "characters", force: :cascade do |t|
    t.string  "name"
    t.string  "gender"
    t.string  "age"
    t.integer "film_id"
    t.integer "species_id"
  end

  create_table "films", force: :cascade do |t|
    t.string  "title"
    t.text    "description"
    t.string  "director"
    t.string  "producer"
    t.integer "release_date"
  end

  create_table "locations", force: :cascade do |t|
    t.string  "name"
    t.string  "terrain"
    t.integer "film_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.string "classification"
  end

end
