class Actor < ActiveRecord::Base
def dbg(sender)
invalid = (self.kind.blank? || self.type.blank?)
p sender + " valid?=" + (!invalid).to_s + " type=" + self.type.to_s + " kind=" + self.kind.to_s + " event_id=" + self.event_id.to_s
end

  attr_accessible :kind , :data , :name , :type , :event_id # , :client_id
  belongs_to :event
  validates_presence_of :kind , :type #, :event_id # TODO:wtf
  before_validation do
self.kind = 'DefaultActorKind' if self.kind.blank?
dbg "Actor::before_validation"
#    self.kind = nil if self.data.blank? && (ACTORS_REQUIRING_DATA.include? self.kind)
  end
  after_validation do
dbg "Actor::after_validation"
  end
  before_create do
dbg "Actor::before_create"
  end
  after_create do
# "Actor::after_create type=" + self.type.to_s + " kind=" + self.kind + " event_id=" + self.event_id.to_s
dbg "Actor::after_create "
#    self.client_id ||= Client.admin.id
  end
end
