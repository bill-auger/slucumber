class Event < ActiveRecord::Base
def dbg(sender) ; p sender + " id=" + self.id.to_s + " project_id=" + self.project_id.to_s ; end ;

  belongs_to :project
  has_one :initiator
  has_one :trigger
  has_one :receiver
  has_one :response
  attr_accessible :tag , :notes , :project_id
attr_accessible :initiator_attributes , :trigger_attributes , :receiver_attributes , :response_attributes
  accepts_nested_attributes_for :initiator , :allow_destroy => true
  accepts_nested_attributes_for :trigger , :allow_destroy => true
  accepts_nested_attributes_for :receiver , :allow_destroy => true
  accepts_nested_attributes_for :response , :allow_destroy => true
#  validates_presence_of :project_id , :initiator , :trigger_id , :receiver_id , :response_id
  validates_presence_of :project_id
  before_validation { self.tag ||= 'Tag:' ; self.notes ||= "" ;
dbg "Event::before_validation" }

  after_create do
=begin
init = Initiator.create({ :kind => "akind" })
p "new Initiator.id=" + init.id
    self.initiator_id = init
    self.trigger_id = Trigger.create({ :kind => "akind" }).id
    self.receiver_id = Receiver.create({ :kind => "akind" }).id
    self.response_id = Response.create({ :kind => "akind" }).id

//    self.initiator.build() ; self.trigger.build() ;
//    self.receiver.build() ; self.response.build() ;

p "event.rb after_create initiator=" + self.initiator_id.to_s
p "event.rb after_create trigger=" + self.trigger.to_s
p "event.rb after_create receiver=" + self.receiver.to_s
p "event.rb after_create response=" + self.response.to_s
=end
#    self.save
=begin
self.build_initiator({ :kind => "aftercreate" })
self.build_trigger({ :kind => "aftercreate" })
self.build_receiver({ :kind => "aftercreate" })
self.build_response({ :kind => "aftercreate" })
self.save
p "Event::after_create initiator=" + self.initiator.id.to_s + " trigger=" + self.trigger.to_s + " receiver=" + self.receiver.to_s + " response=" + self.response.to_s
=end
=begin
self.initiator = self.build_initiator({ :kind => "aftercreate" })
self.trigger = self.build_trigger({ :kind => "aftercreate" })
self.receiver = self.build_receiver({ :kind => "aftercreate" })
self.response = self.build_response({ :kind => "aftercreate" })
=end
p "Event::after_create"
  end
end
