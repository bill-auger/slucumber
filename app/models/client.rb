class Client < ActiveRecord::Base
  attr_accessible :email, :lm, :nick, :notes
end
