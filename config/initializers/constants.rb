
## program constants ##

# initiator and receiver builtin actor kinds
ME_KIND          = 'I'
CREATOR_KIND     = 'The Object Creator'
OWNER_KIND       = 'The Object Owner'
ANY_MEMBER_KIND  = 'Any Group Member'
SAME_MEMBER_KIND = 'Same Group Member'
ALL_MEMBERS_KIND = 'All Group Members'
ANY_USER_KIND    = 'Any Avatar'
SAME_USER_KIND   = 'Same Avatar'
ANY_OBJECT_KIND  = 'Any Object'
SAME_OBJECT_KIND = 'Same Object'

# initiator and receiver custom actor kinds
USER_KIND        = 'Specific User'
OBJECT_KIND      = 'Specific Object'
WEBSITE_KIND     = 'Specific Website'
OUR_BOT_KIND     = 'My Bot'
OUR_OBJECT_KIND  = 'My Object'
OUR_WEBSITE_KIND = 'My Website'
SCANNER_KIND     = 'Scanner'
SENSOR_KIND      = 'Sensor'
INTERVAL_KIND    = 'Repeatedly'
ONCE_KIND        = 'Once When'
WATCH_KIND       = 'Whenever'

# trigger and response action kinds
CHAT_KIND      = 'Chat Message'
LINKMSG_KIND   = 'Link Message'
IM_KIND        = 'Instant Message'
HTTP_KIND      = 'Web Message'
EMAIL_KIND     = 'Email Message'
CLICK_KIND     = 'Click On'
COLLISION_KIND = 'Collides With'
DETECTION_KIND = 'Detected By'
TIMER_KIND     = 'Timer Is'
STATE_KIND     = 'State Is'
MOVE_KIND      = 'Move'
SOUND_KIND     = 'Play Sound'
STORE_KIND     = 'Store Data'


# event actors

INITIATORS = [ME_KIND , CREATOR_KIND , OWNER_KIND ,
              ANY_USER_KIND , ANY_OBJECT_KIND , ANY_MEMBER_KIND ,
              USER_KIND , OBJECT_KIND , WEBSITE_KIND ,
              OUR_BOT_KIND , OUR_OBJECT_KIND , OUR_WEBSITE_KIND ,
              SCANNER_KIND , SENSOR_KIND , INTERVAL_KIND , ONCE_KIND , WATCH_KIND]

AGENT_TRIGGERS    = [CHAT_KIND , IM_KIND , CLICK_KIND , COLLISION_KIND , DETECTION_KIND]
BOT_TRIGGERS      = [CHAT_KIND , IM_KIND , CLICK_KIND , HTTP_KIND , COLLISION_KIND , DETECTION_KIND]
OBJECT_TRIGGERS   = [CHAT_KIND , IM_KIND , HTTP_KIND , EMAIL_KIND , COLLISION_KIND , DETECTION_KIND]
SENSOR_TRIGGERS   = [COLLISION_KIND]
SCANNER_TRIGGERS  = [DETECTION_KIND]
INTERVAL_TRIGGERS = [TIMER_KIND]
ONCE_TRIGGERS     = [TIMER_KIND , STATE_KIND]
WATCH_TRIGGERS    = [STATE_KIND]
WEBSITE_TRIGGERS  = [HTTP_KIND , EMAIL_KIND]

CHAT_RECEIVERS      = [CREATOR_KIND , OWNER_KIND , ALL_MEMBERS_KIND ,
                       SAME_USER_KIND , SAME_OBJECT_KIND , SAME_MEMBER_KIND ,
                       USER_KIND , OBJECT_KIND , WEBSITE_KIND ,
                       OUR_BOT_KIND , OUR_OBJECT_KIND , OUR_WEBSITE_KIND]
CLICK_RECEIVERS     = [SAME_OBJECT_KIND , OBJECT_KIND , OUR_OBJECT_KIND]
COLLISION_RECEIVERS = [OUR_OBJECT_KIND]
DETECTION_RECEIVERS = [OUR_BOT_KIND , OUR_OBJECT_KIND]
NETWORK_RECEIVERS   = [SAME_OBJECT_KIND , OBJECT_KIND ,
                       OUR_BOT_KIND , OUR_OBJECT_KIND , OUR_WEBSITE_KIND]
IM_RECEIVERS        = [CREATOR_KIND , OWNER_KIND , ALL_MEMBERS_KIND ,
                       SAME_USER_KIND , SAME_OBJECT_KIND , SAME_MEMBER_KIND ,
                       USER_KIND , OBJECT_KIND ,
                       OUR_BOT_KIND , OUR_OBJECT_KIND]
STATEFUL_RECEIVERS  = [OUR_BOT_KIND , OUR_OBJECT_KIND , OUR_WEBSITE_KIND]

BOT_RESPONSES     = [HTTP_KIND , EMAIL_KIND , CHAT_KIND , IM_KIND , CLICK_KIND , MOVE_KIND]
OBJECT_RESPONSES  = [HTTP_KIND , EMAIL_KIND , CHAT_KIND , IM_KIND , MOVE_KIND , SOUND_KIND]
WEBSITE_RESPONSES = [HTTP_KIND , EMAIL_KIND , STORE_KIND]

ACTOR_MAP =
{
  :initiators => INITIATORS ,
  :triggers   => { ME_KIND          => AGENT_TRIGGERS ,
                   CREATOR_KIND     => AGENT_TRIGGERS ,
                   OWNER_KIND       => AGENT_TRIGGERS ,
                   ANY_USER_KIND    => AGENT_TRIGGERS ,
                   ANY_OBJECT_KIND  => OBJECT_TRIGGERS ,
                   ANY_MEMBER_KIND  => AGENT_TRIGGERS ,
                   USER_KIND        => AGENT_TRIGGERS ,
                   OBJECT_KIND      => OBJECT_TRIGGERS ,
                   WEBSITE_KIND     => WEBSITE_TRIGGERS ,
                   OUR_BOT_KIND     => BOT_TRIGGERS ,
                   OUR_OBJECT_KIND  => OBJECT_TRIGGERS ,
                   OUR_WEBSITE_KIND => WEBSITE_TRIGGERS ,
                   SCANNER_KIND     => SCANNER_TRIGGERS ,
                   SENSOR_KIND      => SENSOR_TRIGGERS ,
                   INTERVAL_KIND    => INTERVAL_TRIGGERS ,
                   ONCE_KIND        => ONCE_TRIGGERS ,
                   WATCH_KIND       => WATCH_TRIGGERS } ,
  :receivers  => { CLICK_KIND       => CLICK_RECEIVERS ,
                   CHAT_KIND        => CHAT_RECEIVERS ,
                   EMAIL_KIND       => NETWORK_RECEIVERS ,
                   HTTP_KIND        => NETWORK_RECEIVERS ,
                   IM_KIND          => IM_RECEIVERS ,
                   COLLISION_KIND   => COLLISION_RECEIVERS ,
                   DETECTION_KIND   => DETECTION_RECEIVERS ,
                   TIMER_KIND       => STATEFUL_RECEIVERS ,
                   STATE_KIND       => STATEFUL_RECEIVERS } ,
  :responses  => { CREATOR_KIND     => 'n/a' ,
                   OWNER_KIND       => 'n/a' ,
                   ALL_MEMBERS_KIND => 'n/a' ,
                   SAME_USER_KIND   => 'n/a' ,
                   SAME_OBJECT_KIND => 'n/a' ,
                   SAME_MEMBER_KIND => 'n/a' ,
                   USER_KIND        => 'n/a' ,
                   OBJECT_KIND      => 'n/a' ,
                   WEBSITE_KIND     => 'n/a' ,
                   OUR_BOT_KIND     => BOT_RESPONSES ,
                   OUR_OBJECT_KIND  => OBJECT_RESPONSES ,
                   OUR_WEBSITE_KIND => WEBSITE_RESPONSES }
}


# actor classes
=begin
# STATEFUL_INITIATORS are internal script functions - they can not be receivers
STATEFUL_INITIATORS = [SCANNER_KIND , SENSOR_KIND , INTERVAL_KIND , ONCE_KIND , WATCH_KIND]
# STATEFUL_TRIGGERS are initiated by STATEFUL_INITIATORS and require a scriptable receiver
STATEFUL_TRIGGERS   = [COLLISION_KIND , DETECTION_KIND , TIMER_KIND , STATE_KIND]
# STATEFUL_RECEIVERS are those we can script to respond to STATEFUL_TRIGGERS
STATEFUL_RECEIVERS  = [OUR_BOT_KIND , OUR_OBJECT_KIND , OUR_WEBSITE_KIND]
# STATELESS_RECEIVERS are the general ones and those not under our control
#   they can not be the receiver of STATEFUL_TRIGGERS and they can have no output events
STATELESS_RECEIVERS = [ME_KIND , CREATOR_KIND , OWNER_KIND , ALL_MEMBERS_KIND ,
                       ANY_MEMBER_KIND , ANY_USER_KIND , ANY_OBJECT_KIND ,
                       SAME_MEMBER_KIND , SAME_USER_KIND , SAME_OBJECT_KIND ,
                       USER_KIND , OBJECT_KIND , WEBSITE_KIND]
=end
ACTORS_REQ_DATA     = [ANY_MEMBER_KIND , SAME_MEMBER_KIND , ALL_MEMBERS_KIND ,
                       USER_KIND , OBJECT_KIND , WEBSITE_KIND ,
                       OUR_BOT_KIND , OUR_OBJECT_KIND , OUR_WEBSITE_KIND]
# action classes
ACTIONS_REQ_DATA    = [CHAT_KIND , LINKMSG_KIND , IM_KIND , HTTP_KIND , EMAIL_KIND ,
                       COLLISION_KIND , DETECTION_KIND ,
                       TIMER_KIND , STATE_KIND , MOVE_KIND , STORE_KIND]
ACTORS_REQUIRING_DATA = ACTORS_REQ_DATA + ACTIONS_REQ_DATA


## app constants ##

BOGUS_EMAIL                = '@example.net' # so that Client email field will validate
NOREPLY_EMAIL              = 'noreply@example.net' # default email from:
SL_PROXY_EMAIL             = 'mr.j.spam.me@gmail.com' # inworld proxy object email
CONFIRMATION_EMAIL_SUBJECT = 'client_email_confirmation'
