class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :name
      t.text :data

      t.timestamps
    end
  end
end
