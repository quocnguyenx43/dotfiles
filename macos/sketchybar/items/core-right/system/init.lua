local colors = require("colors")
local settings = require("settings")

require("items.core-right.system.battery")
require("items.core-right.system.volume")
require("items.core-right.system.wifi")
require("items.core-right.system.input_sources")

sbar.add("bracket", "system.bracket", {
  "system.battery",
  "system.volume1",
  "system.volume2",
  "system.wifi",
  "TextInputMenuAgent,Item-0"
}, {
  background = {
    color = colors.bg1,
    border_color = colors.transparent,
    height = 30,
    corner_radius = 18,
  }
})

sbar.add("item", { position = "right", width = 25 })
