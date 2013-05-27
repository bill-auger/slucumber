class AddIsAdminToClient < ActiveRecord::Migration
  def change
    add_column :clients , :is_admin , :boolean , { :null => false , :default => false }
  end
end
