class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :initiator_id
      t.integer :trigger_id
      t.integer :receiver_id
      t.integer :response_id
      t.text :notes
      t.integer :project_id

      t.timestamps
    end
  end
end