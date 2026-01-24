local settings = require("settings")

local icons = {
  apple = "􀣺",
  clipboard = "􀉄",
  activity = "􀣋",
  lock = "􀎠",

  cpu = "􀫥",
  ram = "􀫦",
  disk = "􀤂",

  brew = "􀐛",

  volume = {
    _100 = "􀊩",
    _66 = "􀊧",
    _33 = "􀊥",
    _10 = "􀊡",
    _0 = "􀊣",
  },
  battery = {
    _100 = "􀛨",
    _75 = "􀺸",
    _50 = "􀺶",
    _25 = "􀛩",
    _0 = "􀛪",
    charging = "􀢋"
  },
  network = {
    upload = "􀄨",
    download = "􀄩",
    connected = "􀙇",
    connected_hotspot = "􂘟",
    disconnected = "􀙈",
  },
  device = {
    router = "􁓤",
    headphones = "􀑈",
    airpods = "􀪷",
  },
  media = {
    back = "􀊊",
    forward = "􀊌",
    play_pause = "􀊈",
  },
}

return icons
