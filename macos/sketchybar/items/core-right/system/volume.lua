local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local popup_width = 250
local current_audio_device = "None"

-- Volume Percent, e.g. 100%
local volume_percent = sbar.add("item", "system.volume1", {
  position = "right",
  icon = { drawing = false },
  label = {
    string = "??%",
    padding_left = -1,
    font = { family = settings.font.numbers }
  },
})

-- Volume Icon, e.g. 🎵 
local volume_icon = sbar.add("item", "system.volume2", {
  position = "right",
  padding_right = -1,
  icon = {
    drawing = false,
  },
  label = {
    width = 25,
    align = "left",
    font = {
      style = settings.font.style_map["Regular"],
      size = 14.0,
    },
  },
})

-- Volume Anchor
local volume_anchor = volume_icon
volume_anchor:set({ popup = { align = "center" } })
volume_anchor:set({ popup = { align = "center" } })

-- Volume Slider
local volume_slider = sbar.add("slider", popup_width, {
  position = "popup." .. volume_anchor.name,
  slider = {
    highlight_color = colors.blue,
    background = {
      height = 6,
      corner_radius = 3,
      color = colors.bg2,
    },
    knob = {
      string = "􀀁",
      drawing = true,
    },
  },
  background = { color = colors.bg1, height = 2, y_offset = -20 },
  click_script = 'osascript -e "set volume output volume $PERCENTAGE"'
})

-- Percent logic update
volume_percent:subscribe("volume_change", function(env)
  local volume = tonumber(env.INFO)
  local icon = icons.volume._0
  if volume > 60 then
    icon = icons.volume._100
  elseif volume > 30 then
    icon = icons.volume._66
  elseif volume > 10 then
    icon = icons.volume._33
  elseif volume > 0 then
    icon = icons.volume._10
  end

  local lead = ""
  if volume < 10 then
    lead = "0"
  end

  volume_icon:set({ label = icon })
  volume_percent:set({ label = lead })
  volume_slider:set({ slider = { percentage = volume } })

  sbar.exec("/usr/local/bin/SwitchAudioSource -c", function(result)
    local current_device = result:gsub("^%s*(.-)%s*$", "%1")
    
    local current_device = result:gsub("^%s*(.-)%s*$", "%1")

    if current_device:match("Headphones") or current_device:match("Headset") or current_device:match("HAVIT") or current_device:match("Buds") or current_device:match("Pod") then
      icon = icons.device.headphones
    elseif current_device:match("AirPods") then
      icon = icons.device.airpods
    end
    volume_icon:set({ label = icon })
  end)
end)

local function volume_collapse_details()
  local drawing = volume_anchor:query().popup.drawing == "on"
  if not drawing then return end
  volume_anchor:set({ popup = { drawing = false } })
  sbar.remove('/volume.device\\.*/')
end

local function volume_toggle_details(env)
  if env.BUTTON == "right" then
    sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
    return
  end

  local should_draw = volume_anchor:query().popup.drawing == "off"
  if should_draw then
    volume_anchor:set({ popup = { drawing = true } })
    sbar.exec("SwitchAudioSource -t output -c", function(result)
      current_audio_device = result:sub(1, -2)
      sbar.exec("SwitchAudioSource -a -t output", function(available)
        current = current_audio_device
        local color = colors.grey
        local counter = 0

        for device in string.gmatch(available, '[^\r\n]+') do
          local color = colors.grey
          if current == device then
            color = colors.white
          end
          sbar.add("item", "volume.device." .. counter, {
            position = "popup." .. volume_anchor.name,
            width = popup_width,
            align = "center",
            label = { string = device, color = color },
            click_script = 'SwitchAudioSource -s "' .. device .. '" && sketchybar --set /volume.device\\.*/ label.color=' .. colors.grey .. ' --set $NAME label.color=' .. colors.white

          })
          counter = counter + 1
        end
      end)
    end)
  else
    volume_collapse_details()
  end
end

volume_icon:subscribe("mouse.clicked", volume_toggle_details)
volume_percent:subscribe("mouse.clicked", volume_toggle_details)
volume_percent:subscribe("mouse.exited.global", volume_collapse_details)
