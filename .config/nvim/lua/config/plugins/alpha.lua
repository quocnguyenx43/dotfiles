return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            "                                                     ",
            "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
            "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
            "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
            "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
            "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
            "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
            "                                                     ",
        }

        dashboard.section.buttons.val = {
            dashboard.button("n", "  > New file", "<cmd>ene<CR>"),
            dashboard.button("e", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
            dashboard.button("f", "󰱼  > Find file", "<cmd>Telescope find_files<CR>"),
            dashboard.button("r", "  > Recently opened files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("p", "  > Plugins", "<cmd>Lazy<CR>"),
            dashboard.button("c", "  > Neovim config", ":e ~/dotfiles/.config/nvim <CR>"),
            dashboard.button("C", "  > Dotfiles config", ":e ~/dotfiles <CR>"),
            dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
        }

        -- dashboard.section.buttons.val = {
        --   dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
        --   dashboard.button("f", "  Find file (\\ff)", ":Telescope find_files hidden=true no_ignore=true<CR>"),
        --   dashboard.button("F", "  Find git file (\\fF)", ":Telescope git_files<CR>"),
        --   dashboard.button("r", "  Recently opened files (\\fr)", "<cmd>Telescope oldfiles<CR>"),
        --   -- dashboard.button("p", " " .. " Recent projects", ":lua require('telescope').extensions.projects.projects()<CR>"),
        --   dashboard.button("W", "  Find word (\\fW)", "<cmd>Telescope live_grep<cr>"),
        --   dashboard.button("g", "  Find word with args (\\fg)", "<cmd>Telescope live_grep_args<cr>"),
        --   dashboard.button(
        --     "w",
        --     "  Find word in git dir (\\fw)",
        --     "<cmd>lua require'telescope'<cr><cmd>lua require'kiyoon.telescope'.live_grep_gitdir()<cr>"
        --   ),
        --   dashboard.button("d", " " .. " Diff view (\\dv)", "<cmd>DiffviewOpen<CR>"),
        --   dashboard.button("C", " " .. " ChatGPT (\\cg)", "<cmd>GpChatNew<CR>"),
        --   dashboard.button("l", " " .. " Install language support (:Mason)", ":Mason<CR>"),
        --   dashboard.button("P", " " .. " Plugins config", ":e " .. plugins_config_path .. "<CR>"),
        --   dashboard.button("q", " " .. " Quit", ":qa<CR>"),
        -- }

        alpha.setup(dashboard.opts)
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}
