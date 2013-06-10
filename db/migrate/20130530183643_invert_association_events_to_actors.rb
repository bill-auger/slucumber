class InvertAssociationEventsToActors < ActiveRecord::Migration
  def up
    add_column :events , :initiator_id , :integer
    add_column :events , :trigger_id , :integer
    add_column :events , :receiver_id , :integer
    add_column :events , :response_id , :integer

    remove_column :actors , :event_id
  end

  def down
    remove_column :events , :initiator_id
    remove_column :events , :trigger_id
    remove_column :events , :receiver_id
    remove_column :events , :response_id

    add_column :actors , :event_id , :integer
  end
end
