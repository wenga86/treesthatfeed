class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string "name", :null => false
      t.integer "cover_id"
      t.integer "user_id"
      t.string "description"
      t.integer "photo_count"
      t.boolean "approved"
      t.datetime "active_on"
      t.timestamps
    end
  end
end
