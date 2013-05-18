class Project < ActiveRecord::Base
  attr_accessible :notes , :client_id
  belongs_to :client
  has_many :events
end
