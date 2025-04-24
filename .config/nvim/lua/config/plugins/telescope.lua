return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "BurntSushi/ripgrep", -- For live_grep and grep_string
        "sharkdp/fd", -- For faster searching
        -- For sorter performance
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        -- Extensions
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0",
        },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local lga_actions = require("telescope-live-grep-args.actions")

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-t>"] = actions.select_tab, -- Open in new tab
                        ["<C-v>"] = actions.select_vertical, -- Open in vertical window
                        ["<C-h>"] = actions.select_horizontal, -- Open in horizontal window
                        ["<Tab>"] = actions.toggle_selection + actions.move_selection_better, -- Select and move to top
                        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_worse, -- Select and move to bottom 
                        ["<C-a>"] = actions.send_to_qflist + actions.open_qflist,
                        ["<C-e>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    },
                },
                vimgrep_arguments = {
                    "rg",
                    "--follow",
                    "--hidden",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--glob=!**/.git/*",
                    "--glob=!**/.idea/*",
                    "--glob=!**/.vscode/*",
                    "--glob=!**/build/*",
                    "--glob=!**/dist/*",
                    "--glob=!**/yarn.lock",
                    "--glob=!**/package-lock.json",
                },
            },
            pickers = {
                find_files = {
                    file_ignore_patterns = {
                        ".DS_Store",
                        "CVS",
                        "Thumbs.db",
                        ".svn",
                        ".hg",
                        ".git",
                        ".idea",
                        ".venv",
                        "dist",
                        "yarn.lock",
                        "package-lock.json",
                        "node_modules",
                        ".vscode",
                    },
                    hidden = true,
                },
                live_grep = {
                    file_ignore_patterns = {
                        ".DS_Store",
                        "CVS",
                        "Thumbs.db",
                        ".svn",
                        ".hg",
                        ".git",
                        ".idea",
                        ".venv",
                        "dist",
                        "yarn.lock",
                        "package-lock.json",
                        "node_modules",
                        ".vscode",
                    },
                    additional_args = function(_)
                        return { "--hidden" }
                    end,
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                live_grep_args = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-k>"] = lga_actions.quote_prompt(),
                            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            ["<C-space>"] = lga_actions.to_fuzzy_refine,
                        },
                    },
                },
                "noice",
            },
        })

        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")

        local keymap = vim.keymap
        keymap.set( "n", "<leader>ff", "<cmd> Telescope find_files <CR>", { desc = "Telescope files" })
        keymap.set( "n", "<leader>fo", "<cmd> Telescope oldfiles <CR>", { desc = "Telescope old files" })
        keymap.set( "n", "<leader>fg", "<cmd> Telescope git_files <CR>", { desc = "Telescope git files" })
        keymap.set( "n", "<leader>fl", "<cmd> Telescope live_grep <CR>", { desc = "Telescope words" })
        keymap.set( "n", "<leader>fs", "<cmd> lua require('telescope').extensions.live_grep_args.live_grep_args() <CR>", { desc = "Telescope words with args" })
        keymap.set( "n", "<leader>fw", "<cmd> Telescope grep_string <CR>", { desc = "Telescope cursor word" })
        keymap.set( "n", "<leader>fq", "<cmd> Telescope quickfix <CR>", { desc = "Telescope quick fixes" })
        keymap.set( "n", "<leader>ft", "<cmd> Telescope current_buffer_tags<CR>", { desc = "Telescope buffer tags" })
        keymap.set( "n", "<leader>fc", "<cmd> Telescope commands <CR>", { desc = "Telescope commands" })
        keymap.set( "n", "<leader>fk", "<cmd> Telescope keymaps <CR>", { desc = "Telescope keymaps" })
        keymap.set( "n", "<leader>fn", "<cmd> Telescope noice <CR>", { desc = "Telescope noice messages" })
    end,
}
