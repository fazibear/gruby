module GG
  HEADER             = 0x0000
  NEW_STATUS         = 0x0002
  PONG               = 0x0007
  PING               = 0x0008
  SEND_MSG           = 0x000b
  LOGIN              = 0x000c
  ADD_NOTIFY         = 0x000d
  REMOVE_NOTIFY      = 0x000e
  NOTIFY_FIRST       = 0x000f
  NOTIFY_LAST        = 0x0010
  LIST_EMPTY         = 0x0012
  LOGIN_EXT          = 0x0013
  PUBDIR50_REQUEST   = 0x0014
  LOGIN60            = 0x0015
  USERLIST_REQUEST   = 0x0016

  WELCOME            = 0x0001
  STATUS             = 0x0002
  LOGIN_OK           = 0x0003
  SEND_MSG_ACK       = 0x0005
  LOGIN_FAILED       = 0x0009
  RECV_MSG           = 0x000a
  DISCONNECTING      = 0x000b
  NOTIFY_REPLY       = 0x000c
  PUBDIR50_REPLY     = 0x000e
  STATUS60           = 0x000f
  USERLIST_REPLY     = 0x0010
  NOTIFY_REPLY60     = 0x0011
  NEED_EMAIL         = 0x0014

  STATUS_NOT_AVAIL        = 0x0001
  STATUS_NOT_AVAIL_DESCR  = 0x0015
  STATUS_AVAIL            = 0x0002
  STATUS_AVAIL_DESCR      = 0x0004
  STATUS_BUSY             = 0x0003
  STATUS_BUSY_DESCR       = 0x0005
  STATUS_INVISIBLE        = 0x0014
  STATUS_INVISIBLE_DESCR  = 0x0016
  STATUS_BLOCKED          = 0x0006
  STATUS_FRIENDS_MASK     = 0x8000
end
