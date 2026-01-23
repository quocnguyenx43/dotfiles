local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the helper (reused binary name 'disk_load' effectively, but logic is now space)
sbar.exec([[
  killall disk_load >/dev/null;
  $CONFIG_DIR/helpers/disk_load/bin/disk_load disk_update 2.0
]])

local disk = sbar.add("item", "system.disk", 42, {
  position = "right",
  background = {
    height = 22,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    drawing = true,
  },
  icon = { string = "􀤂" },
  label = {
    string = "Checking...",
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    align = "right",
    padding_right = 0,
    width = "dynamic",
    y_offset = 0
  },
  padding_right = settings.paddings + 6
})

disk:subscribe("disk_update", function(env)
  local total_bytes = tonumber(env.total)
  local free_bytes = tonumber(env.free)

  if not total_bytes or not free_bytes then
    return
  end

  local function to_gb_int(bytes)
    return math.floor(bytes / (1024 * 1024 * 1024))
  end

  local total_gb = to_gb_int(total_bytes)
  local free_gb = to_gb_int(free_bytes)

  disk:set({
    label = free_gb .. "/" .. total_gb .. " GB",
  })
end)
