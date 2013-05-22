class ChangeNickInClientToNotnil < ActiveRecord::Migration
  def up
    change_column :clients , :nick , :string , { :null => false }
  end

  def down
    change_column :clients , :nick , :string , { :null => true }
  end
end
