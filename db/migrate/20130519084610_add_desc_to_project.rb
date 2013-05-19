class AddDescToProject < ActiveRecord::Migration
  def change
    add_column :projects , :desc , :string
  end
end
