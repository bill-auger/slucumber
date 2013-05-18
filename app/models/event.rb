class Event < ActiveRecord::Base
  attr_accessible :initiator_id, :notes, :project_id, :receiver_id, :response_id, :trigger_id
end
