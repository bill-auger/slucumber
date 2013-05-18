class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string   :name
      t.text     :data

      t.string   :type
      t.integer  :event_id
      t.timestamps
    end
  end
end
