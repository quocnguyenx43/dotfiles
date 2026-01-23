local colors = require("colors")
local settings = require("settings")

require("items.widgets.brew")
-- require("items.widgets.vpn")

sbar.add("bracket", "custom.widgets.bracket", {
  "widgets.brew"
}, {
  background = {
    color = colors.bg1,
    border_color = colors.transparent,
    height = 30,
    corner_radius = 18,
  }
})

sbar.add("item", { width = settings.group_paddings })
