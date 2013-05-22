class AddNickIndexToClient < ActiveRecord::Migration
  def up
    add_index :clients , :nick , :unique => true
  end

  def down
    remove_index :clients , :column => [:nick]
  end
end
