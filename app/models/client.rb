class Client < ActiveRecord::Base
  has_many :projects
  attr_accessible :nick , :lm , :email , :notes
  validates_presence_of :nick
  before_validation { self.lm ||= "" ; self.email ||= "" ; self.notes ||= "" ; }
end
