class Event < ActiveRecord::Base
  attr_accessible :name , :notes , :project_id
  belongs_to :project
  has_one :initiator
  has_one :trigger
  has_one :receiver
  has_one :response
  validates_presence_of :name , :project_id
  before_validation { self.notes ||= "" }
end
