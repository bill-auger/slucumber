class RenameNameInEventToTag < ActiveRecord::Migration
  def up
    rename_column :events , :name , :tag
  end

  def down
    rename_column :events , :tag , :name
  end
end
