return {
  black=0xff181926,
  white=0xffcad3f5,
  red=0xffed8796,
  green=0xffa6da95,
  blue=0xff8aadf4,
  yellow=0xffeed49f,
  orange=0xfff5a97f,
  magenta=0xffc6a0f6,
  grey=0xff939ab7,
  cyan=0xff94e2d5,
  transparent=0x00000000,

  bg0 = 0x801e1e2e,
  bg1 = 0x801e1e2e,
  bg2 = 0x80494d64,

  bar = {
    bg = 0x801e1e2e,
    border = 0x80494d64,
  },
  popup = {
    bg = 0x801e1e2e,
    border = 0xffcad3f5
  },

  with_alpha = function(color, alpha)
    if alpha > 1.0 or alpha < 0.0 then return color end
    return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
  end,
}
