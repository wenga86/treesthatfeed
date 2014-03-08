class AddControllerAndActionToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :cntrl, :string, :default => 'admin/dashboard'
    add_column :profiles, :actn, :string, :default => 'index'
  end
end
