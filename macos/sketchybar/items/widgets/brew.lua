local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Brew Item
local brew = sbar.add("item", "widgets.brew", {
  position = "right",
  icon = {
    string = icons.brew,
    color = colors.blue,
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
    padding_right = 1,
    padding_left = 1,
  },
  label = {
    string = "0",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    align = "right",
    padding_right = 0,
    padding_left = 6,
  },
  update_freq = 3,
})

-- Update Count
local function validate_count() 
  sbar.exec("brew outdated | wc -l | tr -d ' '", function(count)
    count = tonumber(count)
    local color = colors.red
    
    if count < 10 then
      color = colors.blue
    elseif count < 30 then
      color = colors.yellow
    elseif count < 60 then
      color = colors.orange
    end

    if count == 0 then
      color = colors.green
      count = "✓"
    end

    brew:set({ 
      label = count,
      icon = { color = color }
    })
  end)
end

brew:subscribe({"routine", "brew_update", "mouse.clicked"}, validate_count)
