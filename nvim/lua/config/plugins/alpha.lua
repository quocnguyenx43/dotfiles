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
            dashboard.button("c", "  > Neovim config", ":e ~/.config/nvim <CR>"),
            dashboard.button("C", "  > Dotfiles config", ":e ~/qn/area/dotfiles <CR>"),
            dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
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
        }

        local function footer()
            return "Don't Stop Until You are Proud..."
        end

        dashboard.section.footer.val = footer()

        dashboard.section.footer.opts.hl = "Type"
        dashboard.section.header.opts.hl = "Include"
        dashboard.section.buttons.opts.hl = "Keyword"

        alpha.setup(dashboard.opts)
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
}
