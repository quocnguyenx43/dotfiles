return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()

        -- Telescope harpoon
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

        -- Keymaps
        local keymap = vim.keymap
        keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
            vim.notify("Added buffer to Harpoon!", vim.log.levels.INFO)
        end)
        keymap.set("n", "<leader>h1", function()
            harpoon:list():select(1)
            vim.notify("Go to Harpoon 1", vim.log.levels.INFO)
        end)
        keymap.set("n", "<leader>h2", function()
            harpoon:list():select(2)
            vim.notify("Go to Harpoon 2", vim.log.levels.INFO)
        end)
        keymap.set("n", "<leader>h3", function()
            harpoon:list():select(3)
            vim.notify("Go to Harpoon 3", vim.log.levels.INFO)
        end)
        keymap.set("n", "<leader>h4", function()
            harpoon:list():select(4)
            vim.notify("Go to Harpoon 4", vim.log.levels.INFO)
        end)
        keymap.set("n", "<leader>hn", function()
            harpoon:list():next()
            vim.notify("Go to the next Harpoon", vim.log.levels.INFO)
        end)
        keymap.set("n", "<leader>hp", function()
            harpoon:list():prev()
            vim.notify("Go to the previous Harpoon", vim.log.levels.INFO)
        end)
        keymap.set("n", "<leader>hh", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon window" })

        -- Highlight the current file in the Harpoon buffer list
        local harpoon_extensions = require("harpoon.extensions")
        harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
    end,
}
