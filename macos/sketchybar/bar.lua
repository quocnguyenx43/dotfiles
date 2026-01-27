local colors = require("colors")
local settings = require("settings")

sbar.bar({
  height = 45,
  color = colors.transparent,
  padding_right = 10,
  padding_left = 10,
  margin = -2,
  border_width = 2,
  border_color = colors.transparent,
  sticky = "on",
  position = "bottom",
  shadow = { drawing = true, color = colors.black },
  y_offset = -4,
  topmost = "window",
})

sbar.default({
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Semibold"],
      size = 14.0,
    },
    color = colors.white,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
    background = {
      image = {
        corner_radius = 9
      }
    },
  },
  label = {
    font = {
      family = settings.font.text,
      style = settings.font.style_map["Semibold"],
      size = 13.0
    },
    color = colors.white,
    padding_left = settings.paddings,
    padding_right = settings.paddigs,
  },
  background = {
    height = 30,
    color = colors.transparent,
    border_color = colors.transparent,
    corner_radius = 18,
    image = {
      corner_radius = 18,
      border_color = colors.transparent
    }
  },
  popup = {
    background = {
      border_width = 1,
      corner_radius = 3,
      border_color = colors.popup.border,
      color = colors.popup.bg,
      shadow = { drawing = true },
    },
    blur_radius = 50,
  },
  padding_left = 5,
  padding_right = 5,
  scroll_texts = true,
})
