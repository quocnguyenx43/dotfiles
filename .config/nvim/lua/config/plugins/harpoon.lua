return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        local keymap = vim.keymap
        harpoon:setup({})

        keymap.set("n", "<leader>ha", function() harpoon:list():add() end)

        keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
        keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
        keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
        keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)

        keymap.set("n", "<leader>hn", function() harpoon:list():prev() end)
        keymap.set("n", "<leader>hp", function() harpoon:list():next() end)

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end

        keymap.set("n", "<leader>hh", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon window" })

        harpoon:extend({
            UI_CREATE = function(cx)
                keymap.set("n", "<C-v>", function()
                    harpoon.ui:select_menu_item({ vsplit = true })
                end, { buffer = cx.bufnr })

                keymap.set("n", "<C-x>", function()
                    harpoon.ui:select_menu_item({ split = true })
                end, { buffer = cx.bufnr })

                keymap.set("n", "<C-t>", function()
                    harpoon.ui:select_menu_item({ tabedit = true })
                end, { buffer = cx.bufnr })
            end,
        })

        local harpoon_extensions = require("harpoon.extensions")
        harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
    end,
}
