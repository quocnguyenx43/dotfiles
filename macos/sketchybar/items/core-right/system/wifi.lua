local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

sbar.exec([[
  killall network_load >/dev/null;
  $CONFIG_DIR/helpers/network_load/bin/network_load en0 network_update 5.0
]])

local popup_width = 250

-- Wifi Item
local wifi = sbar.add("item", "system.wifi", {
  position = "right",
  label = { drawing = false },
  popup = { align = "center", height = 30 }
})

--- Popup Item: SSID
local ssid = sbar.add("item", "system.wifi.ssid", {
  position = "popup." .. wifi.name,
  icon = {
    font = {
      style = settings.font.style_map["Bold"]
    },
    string = icons.device.router,
  },
  width = popup_width,
  align = "center",
  label = {
    font = {
      size = 15,
      style = settings.font.style_map["Bold"]
    },
    max_chars = 18,
    string = "????????????",
  },
  background = {
    height = 2,
    color = colors.grey,
    y_offset = -15
  }
})

--- Popup Item: Hostname
local hostname = sbar.add("item", "system.wifi.hostname", {
  position = "popup." .. wifi.name,
  icon = {
    align = "left",
    string = "Hostname:",
    width = popup_width / 2,
  },
  label = {
    max_chars = 20,
    string = "????????????",
    width = popup_width / 2,
    align = "right",
  }
})

--- Popup Item: IP
local ip = sbar.add("item", "system.wifi.ip", {
  position = "popup." .. wifi.name,
  icon = {
    align = "left",
    string = "IP:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  }
})

--- Popup Item: Subnet Mask
local mask = sbar.add("item", "system.wifi.mask", {
  position = "popup." .. wifi.name,
  icon = {
    align = "left",
    string = "Subnet mask:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  }
})

--- Popup Item: Router
local router = sbar.add("item", "system.wifi.router", {
  position = "popup." .. wifi.name,
  icon = {
    align = "left",
    string = "Router:",
    width = popup_width / 2,
  },
  label = {
    string = "???.???.???.???",
    width = popup_width / 2,
    align = "right",
  },
})

wifi:subscribe({"wifi_change", "system_woke"}, function(env)
  sbar.exec("ipconfig getifaddr en0", function(ip)
    local connected = not (ip == "")
    wifi:set({
      icon = {
        string = connected and icons.network.connected or icons.network.disconnected,
        color = connected and colors.white or colors.red,
      },
    })
    
    if connected then
      sbar.exec("/usr/sbin/system_profiler SPAirPortDataType", function(result)
        -- Debug logging
        sbar.exec("echo 'WiFi Output length: " .. #result .. "' >> /tmp/sketchybar_debug.log")
        if result:match("Personal Hotspot: Yes") then
          wifi:set({ icon = { string = icons.network.connected_hotspot } })
        else
             sbar.exec("ipconfig getoption en0 router", function(router_ip)
                if router_ip:match("172.20.10.1") then
                   wifi:set({ icon = { string = icons.network.connected_hotspot } })
                end
             end)
        end
      end)
    end
  end)
end)

local function hide_details()
  wifi:set({ popup = { drawing = false } })
end

local function toggle_details()
  local should_draw = wifi:query().popup.drawing == "off"
  if should_draw then
    wifi:set({ popup = { drawing = true }})
    sbar.exec("networksetup -getcomputername", function(result)
      hostname:set({ label = result })
    end)
    sbar.exec("ipconfig getifaddr en0", function(result)
      ip:set({ label = result })
    end)
    sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
      ssid:set({ label = result })
    end)
    sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Subnet mask: ' '/^Subnet mask: / {print $2}'", function(result)
      mask:set({ label = result })
    end)
    sbar.exec("networksetup -getinfo Wi-Fi | awk -F 'Router: ' '/^Router: / {print $2}'", function(result)
      router:set({ label = result })
    end)
  else
    hide_details()
  end
end

wifi:subscribe("mouse.clicked", toggle_details)
wifi:subscribe("mouse.exited.global", hide_details)

local function copy_label_to_clipboard(env)
  local label = sbar.query(env.NAME).label.value
  sbar.exec("echo \"" .. label .. "\" | pbcopy")
  sbar.set(env.NAME, { label = { string = icons.clipboard, align="center" } })
  sbar.delay(1, function()
    sbar.set(env.NAME, { label = { string = label, align = "right" } })
  end)
end

ssid:subscribe("mouse.clicked", copy_label_to_clipboard)
hostname:subscribe("mouse.clicked", copy_label_to_clipboard)
ip:subscribe("mouse.clicked", copy_label_to_clipboard)
mask:subscribe("mouse.clicked", copy_label_to_clipboard)
router:subscribe("mouse.clicked", copy_label_to_clipboard)
