class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.text     :notes

      t.integer  :project_id
      t.timestamps
    end
  end
end
