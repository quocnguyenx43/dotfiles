local colors = require("colors")
local icons = require("icons")
local settings = require("settings")
local app_icons = require("app_icons")

local SPACE_ICONS_PADDING = 8
local SPACE_ICONS_SUFFIX_PADDING = 4
local LABEL_PADDING = 10

-- Spaces

local spaces = {}

for i = 1, 10, 1 do
  local space = sbar.add("space", "space." .. i, {
    space = i,
    position = "center",
    icon = {
      font = { family = settings.font.numbers, size = 11.0 },
      string = i,
      padding_left = SPACE_ICONS_PADDING,
      padding_right = SPACE_ICONS_SUFFIX_PADDING,
      color = colors.white,
      highlight_color = colors.red,
    },
    label = {
      padding_right = LABEL_PADDING,
      color = colors.grey,
      highlight_color = colors.white,
      font = "sketchybar-app-font:Regular:14.0",
      y_offset = -1,
    },
    padding_right = 1,
    padding_left = 1,
    background = {
      color = colors.bg1,
      height = 22,
      corner_radius = 8,
      border_width = 0,
      border_color = colors.white,
    },
  })

  spaces[i] = space

  -- Padding space between spaces
  sbar.add("space", "space.padding." .. i, {
    space = i,
    script = "",
    position = "center",
    width = settings.group_paddings,
  })

  -- Space Popup
  local space_popup = sbar.add("item", {
    position = "popup." .. space.name,
    padding_left= 5,
    padding_right= 0,
    background = {
      drawing = true,
      image = {
        corner_radius = 9,
        scale = 0.2
      }
    }
  })

  -- Hightlight the focused space
  space:subscribe("space_change", function(env)
    local selected = env.SELECTED == "true"
    space:set({
      icon = { highlight = selected, },
      label = { highlight = selected },
      background = { 
        border_width = selected and 1 or 0,
        border_color = colors.grey
      }
    })
  end)

  -- Mouse click to switch space
  space:subscribe("mouse.clicked", function(env)
    if env.BUTTON == "other" then
      space_popup:set({ background = { image = "space." .. env.SID } })
      space:set({ popup = { drawing = "toggle" } })
    else
      local op = (env.BUTTON == "right") and "--destroy" or "--focus"
      sbar.exec("yabai -m space " .. op .. " " .. env.SID)
    end
  end)
end

-- Cache icons table locally if possible, or ensure it exists
local icons = app_icons or { ["Default"] = "—" }

local function update_focused_window(space_id)
  -- 1. Construct the Yabai Query
  -- Fetch basic space info (index, label) AND windows in that space
  local args = space_id and space_id or ""
  local cmd = "yabai -m query --spaces --space " .. args .. " | jq -r '\"\\(.index)#\\(.label)\"'; " ..
              "yabai -m query --windows --space " .. args .. " | jq -r 'sort_by(.frame.x, .frame.y, .\"stack-index\") | .[] | \"\\(.space)|\\(.app)|\\(.\"has-focus\")\"'"

  sbar.exec(cmd, function(result)
    if not result then return end

    local lines = {}
    for line in result:gmatch("[^\r\n]+") do
      table.insert(lines, line)
    end

    if #lines == 0 then return end

    -- 2. Parse Space Info (First Line)
    -- Format: Index#Label
    local space_idx_str, space_label = lines[1]:match("^(%d+)#(.*)$")
    if not space_idx_str then return end

    local sid = tonumber(space_idx_str)
    if space_label == "null" then space_label = nil end

    -- 3. Parse Windows (Remaining Lines)
    local windows = {}
    for i = 2, #lines do
      -- Pattern: SpaceID | AppName | true/false
      local w_sid, app_name, focused = lines[i]:match("^(%d+)|(.*)|(.*)$")
      if w_sid and app_name then
        table.insert(windows, { app = app_name, focused = (focused == "true") })
      end
    end

    -- 4. Update Space Icon (Index + Label)
    local icon_str = tostring(sid)
    if space_label and space_label ~= "" then
      icon_str = icon_str .. " " .. space_label
    end

    if spaces[sid] then
      spaces[sid]:set({ icon = { string = icon_str } })
    end

    -- 5. Build the Window Icon String
    local icon_line = ""
    for _, w in ipairs(windows) do
      local lookup = icons[w.app]
      local icon = (lookup == nil and icons["Default"] or lookup)

      if w.focused then
        icon = icon .. "*"
      end

      if icon_line == "" then 
        icon_line = icon 
      else 
        icon_line = icon_line .. " " .. icon 
      end
    end

    -- Default to dash if empty
    if icon_line == "" then icon_line = " —" end

    -- 6. Update Sketchybar Label
    if spaces[sid] then 
      spaces[sid]:set({ label = icon_line }) 
    end
  end)
end

local space_window_observer = sbar.add("item", {
  drawing = false,
  updates = true,
})

-- EVENT 1: Space Change
-- env.INFO.space is provided by Sketchybar -> Very Fast
space_window_observer:subscribe("space_windows_change", function(env)
  update_focused_window(env.INFO.space)
end)

-- EVENT 2: App Switch
-- We force a reload of the current space
space_window_observer:subscribe("front_app_switched", function(env)
  update_focused_window(nil)
end)

-- EVENT 3: Window Focus
-- Checks for arguments passed from Yabai signal (See "Next Step" below)
-- yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus SPACE_ID=\$YABAI_SPACE_ID"
space_window_observer:subscribe("window_focus", function(env)
  -- If the signal passes the space ID, use it! Otherwise nil triggers the auto-detection.
  local signal_space = env.SPACE_ID
  update_focused_window(signal_space)
end)

-- Initial update
update_focused_window(nil)
