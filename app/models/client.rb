class Client < ActiveRecord::Base
  attr_accessible :nick , :email , :lm , :notes
  has_many :projects
end
