class RemoveNickFromClient < ActiveRecord::Migration
  def up
    remove_column :clients, :nick
  end

  def down
    add_column :clients, :nick, :string
  end
end
