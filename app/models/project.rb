class Project < ActiveRecord::Base
  attr_accessible :name , :desc , :notes , :client_id
  belongs_to :client
  has_many :events
  validates_presence_of :name , :client_id
  before_validation { self.notes ||= "" }
end
