local settings = require("settings")

local icons = {
  sf_symbols = {
    plus = "􀅼",
    loading = "􀖇",
    apple = "􀣺",
    gear = "􀍟",
    cpu = "􀫥",
    clipboard = "􀉄",
    activity = "􀣋",
    lock = "􀎠",
    brew = "􀐛",
    ram = "􀫦",

    switch = {
      on = "􁏮",
      off = "􁏯",
    },
    volume = {
      _100="􀊩",
      _66="􀊧",
      _33="􀊥",
      _10="􀊡",
      _0="􀊣",
    },
    battery = {
      _100 = "􀛨",
      _75 = "􀺸",
      _50 = "􀺶",
      _25 = "􀛩",
      _0 = "􀛪",
      charging = "􀢋"
    },
    wifi = {
      upload = "􀄨",
      download = "􀄩",
      connected = "􀙇",
      disconnected = "􀙈",
      router = "􁓤",
      hotspot = "􀌕",
    },
    device = {
      headphones = "􀑈",
      airpods = "􀪷",
    },
    media = {
      back = "􀊊",
      forward = "􀊌",
      play_pause = "􀊈",
    },
  },

  nerdfont = {
    plus = "",
    loading = "",
    apple = "",
    gear = "",
    cpu = "",
    clipboard = "Missing Icon",
    activity = "",
    lock = "",
    brew = "",
    ram = "",

    switch = {
      on = "󱨥",
      off = "󱨦",
    },
    volume = {
      _100 = "",
      _66 = "",
      _33 = "",
      _10 = "",
      _0 = "",
    },
    battery = {
      _100 = "",
      _75 = "",
      _50 = "",
      _25 = "",
      _0 = "",
      charging = ""
    },
    wifi = {
      upload = "",
      download = "",
      connected = "󰖩",
      disconnected = "󰖪",
      router = "Missing Icon",
      hotspot = "󰌾",
    },
    device = {
      headphones = "",
      airpods = "",
    },
    media = {
      back = "",
      forward = "",
      play_pause = "",
    },
  },
}

if not (settings.icons == "NerdFont") then
  return icons.sf_symbols
else
  return icons.nerdfont
end
