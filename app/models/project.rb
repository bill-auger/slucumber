class Project < ActiveRecord::Base
def dbgactors(sender)
p sender + ((self.events.first.initiator.nil?)? "nil" : self.events.first.initiator.id.to_s)
end
def dbgevents(sender)
p sender + ((self.events.nil?)? "nil" : self.events.size.to_s)
end

  belongs_to :client
  has_many :events
  accepts_nested_attributes_for :events , :allow_destroy => true
  attr_accessible :name , :desc , :notes , :client_id , :events_attributes
  validates_presence_of :name , :client_id
  before_validation { self.desc ||= "" ; self.notes ||= "" }
=begin
  before_create {
p "event.rb before_create  IN n_events=" + ((self.events)? self.events.size.to_s : "events nil")
    self.events.create() ;
p "event.rb OUT n_events=" + ((self.events)? self.events.size.to_s : "events nil")
  }
=end
  after_create {
dbgevents "project.rb after_create  IN n_events=" #; return if true ;
#    an_event = self.events.create() ;
    self.events.build() ; return if self.events.size.zero? ;
#self.events.first.build_initiator() ; self.events.first.build_trigger() ;
#self.events.first.build_receiver() ; self.events.first.build_response() ;
#self.events.first.self.save
=begin
self.events.build_initiator({}) ; self.events.build_trigger({}) ;
self.events.build_receiver({}) ; self.events.build_response({}) ;
self.save
=end
#dbgactors "project.rb after_create initiator    ="
    self.save
#dbgactors "project.rb after_create initiator OUT="
dbgevents "project.rb after_create OUT n_events="
  }


  def admin? ; self.is_admin ; end ;

  def self.form_remote? ; true ; end ;

  def self.display_projects(projects) # projectNameTd styling
    longest_name = "" ; longest = 0 ;
    projects.each do | project |
      name = project.name ; n_chars = name.size ;
      longest_name = name and longest = n_chars if n_chars > longest ;
    end
    longest_name
  end
end
