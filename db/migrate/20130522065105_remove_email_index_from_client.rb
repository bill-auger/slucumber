class RemoveEmailIndexFromClient < ActiveRecord::Migration
  def up
    remove_index :clients , :column => [:email]
  end

  def down
    add_index :clients , :email , :unique => true
  end
end
