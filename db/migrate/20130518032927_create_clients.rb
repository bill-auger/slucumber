class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string   :nick
      t.string   :email
      t.string   :lm
      t.text     :notes

      t.timestamps
    end
  end
end
