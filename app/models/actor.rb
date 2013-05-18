class Actor < ActiveRecord::Base
  attr_accessible :name , :data , :event_id
  belongs_to :event
end
