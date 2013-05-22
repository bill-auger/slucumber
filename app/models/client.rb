class Client < ActiveRecord::Base
  has_many :projects
  # Include default devise modules. Others available are:
  # :timeoutable , :omniauthable , :validatable
  devise :database_authenticatable , :registerable ,
         :recoverable , :rememberable , :trackable ,
         :token_authenticatable , :confirmable , :lockable

  attr_accessible :nick , :password , :password_confirmation , :remember_me , :email
  attr_accessible :landmark , :notes
  validates_uniqueness_of :nick , { :case_sensitive => false }
  validates_presence_of :nick # TODO: Devise should handle this
  validates_presence_of :password , :password_confirmation , { :on => :create }
  validates_confirmation_of :password
  validates_length_of :password , { :within => Devise.password_length , :on => :create }
  before_validation :validate

  # NOTE: this will require several Devise methods to be overridden - we punt for now
  #   but we maybe able to trigger reconfirmation on changes to the nick field instead
  #   keeping the email column internally (all set to SL_PROXY_EMAIL) or lose it completely
  #   also i think reconfirmation will not work until we do so
  def email_required? ; false ; end ;
  def validate()
    # NOTE: we EVENTUALLY WANT TO BE sending all email to our inworld object
    #   to relay the confirmation links to the client
    #   but devise requires the email field for confirmable and recoverable
    #   we will set the email field to SL_PROXY_EMAIL for now but we may need tp
    #   use the email field to hold the client's SL nick instead nick@SL_PROXY_EMAIL
    self.nick = self.nick.delete('^A-Za-z0-9 .').gsub(' ' , '.') unless self.nick.nil?
    self.email = SL_PROXY_EMAIL ; self.landmark ||= "" ; self.notes ||= "" ;
  end
end
