class Client < ActiveRecord::Base
  has_many :projects
  # Include default devise modules. Others available are:
  # :timeoutable , :omniauthable , :validatable
  devise :database_authenticatable , :registerable ,
         :recoverable , :rememberable , :trackable ,
         :token_authenticatable , :confirmable , :lockable

  attr_accessible :nick , :password , :password_confirmation , :landmark , :notes
  attr_accessible :remember_me , :email , :unconfirmed_email , :is_admin
  validates_uniqueness_of :nick , { :case_sensitive => false }
  validates_presence_of :nick
  validates_presence_of :password , :password_confirmation , { :on => :create }
  validates_confirmation_of :password
  before_validation do
    # NOTE: we send all confirmation email to our inworld object to relay to the client
    #   but devise requires the email field to change for confirmable and recoverable
    self.nick = self.nick.delete('^A-Za-z0-9 .').gsub(' ' , '.') unless self.nick.nil?
    self.email = self.unconfirmed_email = self.nick + BOGUS_EMAIL unless self.nick.blank?
    self.landmark ||= "" ; self.notes ||= "" ;
  end

  def admin ; Client.find_by_nick 'me' ; end ;

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


  def self.display_clients(current_client) # clientLoginTd styling
    clients = [] ; display_nicks = [] ; longest_named_client = nil ; longest = 0 ;
    self.all.each do | client | ; next if client == current_client ;
      curr_nick = client.email.split('@').first ; new_nick = client.nick ;
      display_nick = (new_nick == curr_nick)? curr_nick : curr_nick + " (" + new_nick + ")"
      clients << client ; display_nicks << display_nick ; n_chars = display_nick.size ;
      longest_named_client = client and longest = n_chars if n_chars > longest ;
    end
    [clients , display_nicks , longest_named_client]
  end
end
