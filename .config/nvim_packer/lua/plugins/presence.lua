local version = vim.version()

--editing text: Neovim version
-- interpolate the version number into the string
local editingText =  "v" .. version.major .. '.' .. version.minor .. '.' .. version.patch

require('presence'):setup({
    neovim_image_text = 'You soydevs won\'t understand',
    main_image = 'file',
    editing_text =  editingText,
    file_explorer_text = 'Browsing files',
    reading_text = 'Reading files',
    workspace_text = 'Vim ❤️ ☕️',
    enable_line_number = false,
    buttons = false
})
