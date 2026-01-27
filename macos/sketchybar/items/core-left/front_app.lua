local colors = require("colors")
local settings = require("settings")

-- Front app
local front_app = sbar.add("item", "front_app", {
  display = "active",
  position = "center",
  icon = {
    drawing = true,
    align = "center",
    width = 22,
    background = {
      drawing = true,
      image = {
        corner_radius = 6,
        scale = 0.6,
      }
    }
  },
  label = {
    font = {
      style = settings.font.style_map["Black"],
      size = 11.0,
    },
  },
  updates = true,
})

-- Front app switch
front_app:subscribe("front_app_switched", function(env)
  front_app:set({
    label = { string = env.INFO },
    icon = {
      background = {
        image = "app." .. env.INFO 
      }
    }
  })
end)
