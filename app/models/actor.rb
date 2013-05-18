class Actor < ActiveRecord::Base
  attr_accessible :name , :data , :kind , :type , :event_id
  belongs_to :event
  validates_presence_of :name , :kind , :type , :event_id
end
