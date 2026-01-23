local colors = require("colors")
local settings = require("settings")

require("items.system-stats-right.disk")
require("items.system-stats-right.ram")
require("items.system-stats-right.cpu")
-- require("items.system-stats-right.network")

sbar.add("bracket", "system.stats.bracket", {
  "system.disk",
  "system.cpu",
  "system.ram",
  -- "system.network",
}, {
  background = {
    color = colors.bg1,
    border_color = colors.transparent,
    height = 30,
    corner_radius = 18,
    padding_left = 10,
    padding_right = 20,
  }
})

sbar.add("item", { position = "right", width = 8 })
