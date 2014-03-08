class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name
      t.string :label
      t.text :settings
      t.timestamps
    end
  end
end
