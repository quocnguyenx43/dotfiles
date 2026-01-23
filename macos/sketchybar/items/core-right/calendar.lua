local settings = require("settings")
local colors = require("colors")

-- Calendar
local cal = sbar.add("item", "calendar", {
  icon = {
    color = colors.white,
    padding_left = 20,
    padding_right = 20,
    font = {
      style = settings.font.style_map["Bold"],
      size = 14.0,
    },
  },
  label = {
    color = colors.white,
    padding_right = 20,
    width = 45,
    align = "right",
    font = { family = settings.font.numbers },
  },
  position = "right",
  update_freq = 30,
  padding_left = 15,
  background = {
    color = colors.bg1,
  },
  click_script = "open -a 'Calendar'"
})

-- Update Calendar
cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
  cal:set({ icon = "􀉉  " .. os.date("%a %d. %b"), label = os.date("%H:%M") })
end)
