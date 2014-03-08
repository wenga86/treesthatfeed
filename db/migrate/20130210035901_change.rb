class Change < ActiveRecord::Migration
  def up
    rename_column :resources, :article_id, :resourcable_id
    add_column  :resources, :resourcable_type, :string
  end

  def down
    rename_column :resources, :resourcable_id, :article_id
    remove_column  :resources, :resourcable_type, :string
  end
end
