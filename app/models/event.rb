class Event < ActiveRecord::Base
  attr_accessible :notes , :project_id
  belongs_to :project
  has_one :initiator
  has_one :trigger
  has_one :receiver
  has_one :response
end
