class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :nick
      t.string :lm
      t.string :email
      t.text :notes

      t.timestamps
    end
  end
end
