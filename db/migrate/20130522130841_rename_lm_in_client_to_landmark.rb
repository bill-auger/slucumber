class RenameLmInClientToLandmark < ActiveRecord::Migration
  def up
		rename_column :clients , :lm , :landmark
  end

  def down
		rename_column :clients , :landmark , :lm
  end
end
