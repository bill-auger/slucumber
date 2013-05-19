class Client < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable , :registerable ,
         :recoverable , :rememberable , :trackable , :validatable ,
         :token_authenticatable , :confirmable , :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email , :password , :password_confirmation , :remember_me
  has_many :projects
  attr_accessible :lm , :notes
  before_validation { self.lm ||= "" ; self.notes ||= "" ; }
end
