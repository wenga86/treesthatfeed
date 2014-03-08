class CreateUsersTypes < ActiveRecord::Migration
  def up
    create_table :users_types, :id => false do |t|
      t.integer :user_id
      t.integer :type_id
    end

    add_index :users_types, [:user_id, :type_id]
  end

  def down
    drop_table :users_types
  end
end
