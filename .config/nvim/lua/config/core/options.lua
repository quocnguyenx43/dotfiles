local g = vim.g
local o = vim.o
local wo = vim.wo
local opt = vim.opt
local env = vim.env
local cmd = vim.cmd
local fn = vim.fn

-- General
o.mouse = "a" -- Enable mouse move
o.undofile = true -- Save undo hist on file
opt.swapfile = false -- Create temp file for recovering when crashed
opt.clipboard = "unnamedplus" -- Copying into general register
opt.cursorline = true -- Hightlights the current line
opt.virtualedit = "block" -- Best for editing
opt.wrap = false -- Dont wrap text
opt.colorcolumn = "95" -- Column
opt.scrolloff = 5 -- Min lines keep below the cursor
opt.fillchars:append({
    vert = "┃",
    horiz = "━",
    horizup = "┻",
    horizdown = "┳",
    vertleft = "┫",
    vertright = "┣",
    verthoriz = "╋",
})

-- Diagnostic symbols
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Foldings
o.foldenable = true -- Enable folding
o.foldcolumn = "1" -- Show all available fold in the left
o.foldlevel = 20 -- Fold level when editing a file, 99 means fold all
o.foldlevelstart = 99 -- Fold level when opening a file, 99 means expand all
wo.foldmethod = "expr" -- Folding using expr
wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Folding with nvim-treesitter

-- https://github.com/Wansmer/nvim-config/blob/main/lua/modules/foldtext.lua
local function parse_line(linenr)
    local bufnr = vim.api.nvim_get_current_buf()

    local line = vim.api.nvim_buf_get_lines(bufnr, linenr - 1, linenr, false)[1]
    if not line then
        return nil
    end

    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok then
        return nil
    end

    local query = vim.treesitter.query.get(parser:lang(), "highlights")
    if not query then
        return nil
    end

    local tree = parser:parse({ linenr - 1, linenr })[1]
    local result = {}
    local line_pos = 0

    for id, node, metadata in query:iter_captures(tree:root(), 0, linenr - 1, linenr) do
        local name = query.captures[id]
        local start_row, start_col, end_row, end_col = node:range()

        local priority = tonumber(metadata.priority or vim.highlight.priorities.treesitter)

        if start_row == linenr - 1 and end_row == linenr - 1 then
            if start_col > line_pos then
                table.insert(result, {
                    line:sub(line_pos + 1, start_col),
                    { { "Folded", priority } },
                    range = { line_pos, start_col },
                })
            end
            line_pos = end_col

            local text = line:sub(start_col + 1, end_col)
            table.insert(
                result,
                { text, { { "@" .. name, priority } }, range = { start_col, end_col } }
            )
        end
    end

    local i = 1
    while i <= #result do
        local j = i + 1
        while
            j <= #result
            and result[j].range[1] >= result[i].range[1]
            and result[j].range[2] <= result[i].range[2]
        do
            for k, v in ipairs(result[i][2]) do
                if not vim.tbl_contains(result[j][2], v) then
                    table.insert(result[j][2], k, v)
                end
            end
            j = j + 1
        end

        if j > i + 1 then
            table.remove(result, i)
        else
            if #result[i][2] > 1 then
                table.sort(result[i][2], function(a, b)
                    return a[2] < b[2]
                end)
            end

            result[i][2] = vim.tbl_map(function(tbl)
                return tbl[1]
            end, result[i][2])
            result[i] = { result[i][1], result[i][2] }

            i = i + 1
        end
    end

    return result
end

function fold_text()
    local text = parse_line(vim.v.foldstart)

    local n_lines = vim.v.foldend - vim.v.foldstart
    local text_lines = " lines"

    if n_lines == 1 then
        text_lines = " line"
    end

    table.insert(text, { " - " .. n_lines .. text_lines, { "Folded" } })

    return text
end
wo.foldtext = "v:lua.fold_text()" -- Custom wrapper folding text

-- Line number
opt.number = true -- Line number
opt.relativenumber = true -- Relative line number

-- Indent & tabs
opt.expandtab = true -- Tabs to spaces
opt.tabstop = 4 -- Tab size
opt.softtabstop = 4
opt.shiftwidth = 4 -- Each indentation
opt.autoindent = true
opt.smartindent = true

-- Search
opt.ignorecase = true -- Case-insensitive
opt.smartcase = true -- Smarter
opt.inccommand = "split" -- Show effects real time
opt.hlsearch = true -- Highlight on search
opt.incsearch = true -- Real time highlight on search

-- Splits
opt.splitbelow = true -- Split below first
opt.splitright = true -- Split right first

-- Colors
opt.termguicolors = true
if
    env.TERM == "st-256color"
    or env.TERM == "tmux-256color"
    or env.TERM == "xterm-256color"
then
    cmd("set termguicolors")
end

-- Disable default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
