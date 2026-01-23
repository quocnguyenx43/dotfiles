local colors = require("colors")
local settings = require("settings")

-- [[ Input Source Alias ]] --
sbar.add("event", "input_change", "AppleSelectedInputSourcesChangedNotification")

local input = sbar.add("alias", "TextInputMenuAgent,Item-0", {
  position = "right",
  width = 35,
  alias = {
    color = colors.white,
  },
  icon = { drawing = true },
  label = { drawing = false },
  padding_left = 0,
  padding_right = 0,
})

input:subscribe({"input_change", "system_woke"}, function(env) end)
