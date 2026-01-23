local colors = require("colors")
local icons = require("icons")

-- Apple Logo
local apple_logo = sbar.add("item", "apple.logo", {
  icon = {
    font = { size = 16.0 },
    string = icons.apple,
    padding_right = 12,
    padding_left = 12,
  },
  label = { drawing = false },
  background = {
    color = colors.bg1,
    corner_radius = 27,
  },
  padding_left = 1,
  padding_right = 1,
  popup = {
    align = "left"
  }
})

-- Popup Menu
apple_logo:subscribe("mouse.clicked", function(env)
  apple_logo:set({ popup = { drawing = "toggle" } })
end)

-- -- Popup Item: Activity Monitor
-- sbar.add("item", "apple.activity", {
--   position = "popup." .. apple_logo.name,
--   -- icon = { string = icons.activity, align = "left" },
--   label = {
--     string = "Activity",
--     align = "right",
--     padding_left = 0,
--     padding_right = 4,
--   },
--   background = { color = colors.bg1, corner_radius = 5, height = 24 },
--   padding_right = 5,
--   click_script = "open -a 'Activity Monitor'; sketchybar --set apple.logo popup.drawing=off"
-- })

sbar.add("item", "apple.sleep", {
  position = "popup." .. apple_logo.name,
  -- icon = { string = icons.sleep, align = "left" },
  label = { 
    string = "Sleep",
    align = "right",
    padding_left = 0,
    padding_right = 4,
  },
  background = { color = colors.bg1, corner_radius = 5, height = 24 },
  padding_right = 5,
  click_script = "pmset sleepnow; sketchybar --set apple.logo popup.drawing=off"
})

-- Popup Item: Lock Screen
sbar.add("item", "apple.lock", {
  position = "popup." .. apple_logo.name,
  -- icon = { string = icons.lock, align = "left" },
  label = {
    string = "Lock Screen",
    align = "right",
    padding_left = 0,
    padding_right = 4,
  },
  background = { color = colors.bg1, corner_radius = 5, height = 24 },
  padding_right = 5,
  click_script = "pmset displaysleepnow; sketchybar --set apple.logo popup.drawing=off"
})
