return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local treesitter_config = require("nvim-treesitter.configs")
        treesitter_config.setup({
            ensure_installed = {
                "vim",
                "lua",
                "json",
                "markdown",
                "markdown_inline",
                "bash",
                "dockerfile",
                "regex",
                "xml",
                "yaml",
                "c",
                "cpp",
                "java",
                "python",
                "scala",
                "sql",
                "scala",
                "javascript",
            },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Leader>ss",
                    node_incremental = "<Leader>si",
                    node_decremental = "<Leader>sd",
                    scope_incremental = "<Leader>sc",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                        ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                        ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                        ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                        ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                        ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                        ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                        ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                        ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                        ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                        ["am"] = {
                            query = "@function.outer",
                            desc = "Select outer part of a method/function definition",
                        },
                        ["im"] = {
                            query = "@function.inner",
                            desc = "Select inner part of a method/function definition",
                        },

                        ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                    },
                },
                swap = {
                    enable = true,
                    swap_text = {
                        ["<leader>na"] = "@parameter.inner",
                        ["<leader>nm"] = "@function.outer",
                    },
                    swap_previous = {
                        ["<leader>pa"] = "@parameter.inner",
                        ["<leader>pm"] = "@function.outer",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]f"] = { query = "@call.outer", desc = "Next function call start" },
                        ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_next_end = {
                        ["]F"] = { query = "@call.outer", desc = "Next function call end" },
                        ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
                        ["]C"] = { query = "@class.outer", desc = "Next class end" },
                        ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                        ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                    },
                    goto_previous_start = {
                        ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
                        ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
                        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
                        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                    },
                    goto_previous_end = {
                        ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
                        ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
                        ["[C"] = { query = "@class.outer", desc = "Prev class end" },
                        ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                        ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                    },
          lsp_interop = {
            enable = true,
            border = "none",
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>dff"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
                },
            },
        })

        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
    end,
}
