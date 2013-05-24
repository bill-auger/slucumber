class Client < ActiveRecord::Base
  has_many :projects
  # Include default devise modules. Others available are:
  # :timeoutable , :omniauthable , :validatable
  devise :database_authenticatable , :registerable ,
         :recoverable , :rememberable , :trackable ,
         :token_authenticatable , :confirmable , :lockable

  attr_accessible :nick , :password , :password_confirmation , :landmark , :notes
  attr_accessible :remember_me , :email , :unconfirmed_email , :previous_nick
  validates_uniqueness_of :nick , { :case_sensitive => false }
  validates_presence_of :nick # TODO: Devise should handle this
  validates_presence_of :password , :password_confirmation , { :on => :create }
  validates_confirmation_of :password
  validates_length_of :password , { :within => Devise.password_length , :on => :create }
  before_validation do
    # NOTE: we send all confirmation email to our inworld object to relay to the client
    #   but devise requires the email field to change for confirmable and recoverable
    self.nick = self.nick.delete('^A-Za-z0-9 .').gsub(' ' , '.') unless self.nick.nil?
    self.email = self.unconfirmed_email = self.nick + BOGUS_EMAIL unless self.nick.blank?
    self.landmark ||= "" ; self.notes ||= "" ; self.previous_nick || "" ;
  end


  module Devise::Models::Confirmable
    def send_on_create_confirmation_instructions # on create
      SlMailer.sl_email(self).deliver
    end

    def send_confirmation_instructions # on update
      self.confirmation_token = nil if reconfirmation_required?
      @reconfirmation_required = false
      generate_confirmation_token! if self.confirmation_token.blank?
      SlMailer.sl_email(self).deliver
    end
  end

end