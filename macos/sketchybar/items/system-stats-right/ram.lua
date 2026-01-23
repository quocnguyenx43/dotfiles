local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

sbar.exec([[
  killall ram_load >/dev/null;
  $CONFIG_DIR/helpers/ram_load/bin/ram_load ram_update 5.0
]])

local ram = sbar.add("graph", "system.ram" , 42, {
  position = "right",
  graph = { color = colors.blue },
  background = {
    height = 22,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    drawing = true,
  },
  icon = { string = icons.ram },
  label = {
    string = "ram ??%",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    align = "right",
    padding_right = 0,
    width = 0,
    y_offset = 4
  },
  padding_right = settings.paddings + 6
})

ram:subscribe("ram_update", function(env)
  -- Also available: env.user_load, env.sys_load
  local load = tonumber(env.percentage)
  ram:push({ load / 100. })

  local color = colors.blue
  if load > 30 then
    if load < 60 then
      color = colors.yellow
    elseif load < 80 then
      color = colors.orange
    else
      color = colors.red
    end
  end

  ram:set({
    graph = { color = color },
    label = "ram " .. env.percentage .. "%",
  })
end)

sbar.add("item", { position = "right", width = settings.group_paddings })
