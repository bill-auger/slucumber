
## program constants ##

# initiator and receiver builtin kinds
CREATOR_KIND = 'object_creator'
OWNER_KIND = 'object_owner'
MEMBER_KIND = 'group_member'
ANY_USER_KIND = 'any_agent'
ANY_OBJECT_KIND = 'any_object'
LOCAL_CHAT = 'local_chat'
# initiator and receiver custom kinds
USER_KIND = 'user'
OBJECT_KIND = 'object'
WEBSITE_KIND = 'website'
OUR_OBJECT_KIND = 'our_object'
OUR_WEBSITE_KIND = 'our_website'
BOT_KIND = 'our_bot'
# trigger and response kinds
CLICK_KIND = 'click'
CHAT_KIND = 'chat_msg'
LINKMSG_KIND = 'link_msg'
IM_KIND = 'im_msg'
HTTP_KIND = 'http_msg'
EMAIL_KIND = 'email_msg'
CHECK_EMAIL_KIND = 'check_email'
TIMER_KIND = 'timer'
STATE_KIND = 'state'
# actor classes
ACTIONS_REQ_DATA = [CHAT_KIND , LINKMSG_KIND , IM_KIND , HTTP_KIND , EMAIL_KIND , TIMER_KIND , STATE_KIND]
STATELESS_KINDS = [ANY_USER_KIND , ANY_OBJECT_KIND , LOCAL_CHAT]


## app constants ##

SL_PROXY_EMAIL = 'mr.j.spam.me@gmail.com' # inworld proxy object email
