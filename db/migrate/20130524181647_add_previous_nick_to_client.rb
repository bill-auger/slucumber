class AddPreviousNickToClient < ActiveRecord::Migration
  def change
    add_column :clients , :previous_nick , :string
  end
end
