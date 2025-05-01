return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local treesitter_config = require("nvim-treesitter.configs")

        treesitter_config.setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    -- Do with Visual Mode
                    keymaps = {
                        -- Assignments
                        ["o="] = { query = "@assignment.outer", desc = "Select outer part of an assignment", },
                        ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment", },
                        ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment", },
                        ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment", },

                        -- Parameters
                        ["po"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument", },
                        ["pi"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument", },

                        -- Parameters
                        ["bo"] = { query = "@block.outer", desc = "Select outer part of a block", },
                        ["bi"] = { query = "@block.inner", desc = "Select inner part of a block", },

                        -- Conditional if
                        ["io"] = { query = "@conditional.outer", desc = "Select outer part of a conditional", },
                        ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional", },

                        -- Loop
                        ["lo"] = { query = "@loop.outer", desc = "Select outer part of a loop", },
                        ["li"] = { query = "@loop.inner", desc = "Select inner part of a loop", },

                        -- Reference
                        ["ro"] = { query = "@call.outer", desc = "Select outer part of a function call", },
                        ["ri"] = { query = "@call.inner", desc = "Select inner part of a function call", },

                        -- Function
                        ["fo"] = { query = "@function.outer", desc = "Select outer part of a method/function definition", },
                        ["fi"] = { query = "@function.inner", desc = "Select inner part of a method/function definition", },

                        -- Class
                        ["co"] = { query = "@class.outer", desc = "Select outer part of a class", },
                        ["ci"] = { query = "@class.inner", desc = "Select inner part of a class", },

                        -- Comment
                        ["Co"] = { query = "@comment.outer", desc = "Select outer part of a comment", },
                        ["Ci"] = { query = "@comment.inner", desc = "Select inner part of a comment", },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>pn"] = "@parameter.inner",
                        ["<leader>fn"] = "@function.outer",
                        ["<leader>fo"] = "@function.inner",
                    },
                    swap_previous = {
                        ["<leader>pp"] = "@parameter.inner",
                        ["<leader>fp"] = "@function.outer",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]r"] = { query = "@call.outer", desc = "Next function call start" },
                        ["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
                        ["]c"] = { query = "@class.outer", desc = "Next class start" },
                        ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                        ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                        ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                    },
                    goto_previous_start = {
                        ["[r"] = { query = "@call.outer", desc = "Prev function call start" },
                        ["[f"] = { query = "@function.outer", desc = "Prev method/function def start", },
                        ["[c"] = { query = "@class.outer", desc = "Prev class start" },
                        ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start", },
                        ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                        ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
                        ["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
                    }
                },
            },
        })

        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}
