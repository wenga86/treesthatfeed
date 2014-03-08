class CreateImages < ActiveRecord::Migration
  def change
    create_table "photos", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer "album_id", :null => false
      t.integer "user_id", :null => false
      t.integer "sort"
      t.boolean  "photo_processing"
      t.string "photo_description"
      t.string   "photo",                               :null => false
    end
  end
end
