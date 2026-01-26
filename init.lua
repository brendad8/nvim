local vim = vim

-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"
vim.o.completeopt = "menuone,noselect,popup"
vim.o.pumheight = 8



-- Highlight text when copying
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})


-- Keymaps
vim.keymap.set("n", "<leader>so", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>qq", ":quit<CR>")

vim.keymap.set("n", "<Tab>", ">>")
vim.keymap.set("n", "<S-Tab>", "<<")

vim.keymap.set("v", "<Tab>", ">gv")
vim.keymap.set("v", "<S-Tab>", "<gv")

vim.keymap.set("n", "<leader>bd", ":bd<CR>")
vim.keymap.set("n", "<leader>bD", ":bd!<CR>")

vim.keymap.set("n", "<leader>-", ":vert botr new<CR>")
vim.keymap.set("n", "<leader>|", ":belowr new<CR>")

vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>l", "<C-w>l")

vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format)

vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n><C-y>"
    else
        return "<Tab>"
    end
end, { expr = true })


-- Plugins
vim.pack.add({
    { src = "https://github.com/sainnhe/everforest" },

    { src = "https://github.com/nvim-mini/mini.ai" },
    { src = "https://github.com/nvim-mini/mini.cmdline" },
    { src = "https://github.com/nvim-mini/mini.completion" },
    { src = "https://github.com/nvim-mini/mini.extra" },
    { src = "https://github.com/nvim-mini/mini.icons" },
    { src = "https://github.com/nvim-mini/mini.pairs" },
    { src = "https://github.com/nvim-mini/mini.pick" },
    { src = "https://github.com/nvim-mini/mini.snippets" },
    { src = "https://github.com/nvim-mini/mini.splitjoin" },
    { src = "https://github.com/nvim-mini/mini.surround" },
    { src = "https://github.com/nvim-mini/mini.tabline" },

    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/stevearc/quicker.nvim" },

    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})


-- Colorsheme
vim.cmd("colorscheme everforest")

-- Mini Plugins
require("mini.extra").setup()
require("mini.ai").setup({
    custom_textobjects = {
        B = MiniExtra.gen_ai_spec.buffer(),
        I = MiniExtra.gen_ai_spec.indent(),
        L = MiniExtra.gen_ai_spec.line()
    }
})
require("mini.cmdline").setup()
require("mini.completion").setup({
    delay = { completion = 50, info = 50, signature = 25 },
    lsp_completion = {
        source_func = "completefunc",
        auto_setup = true,
        process_items = nil,
        snippet_insert = vim.snippet.expand,
    },
    fallback_action = "<C-n>",
    window = {
        info = { height = 25, width = 80, border = "rounded" },
        signature = { height = 25, width = 80, border = "rounded" },
    },
})
require("mini.pairs").setup({
    mappings = {
        [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
        ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
        ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
        ["["] = { action = "open", pair = "[]", neigh_pattern = ".[%s%z%)}%]]", register = { cr = false }, },
        ["{"] = { action = "open", pair = "{}", neigh_pattern = ".[%s%z%)}%]]", register = { cr = false }, },
        ["("] = { action = "open", pair = "()", neigh_pattern = ".[%s%z%)]", register = { cr = false }, },
        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%w\\][^%w]", register = { cr = false }, },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%w\\][^%w]", register = { cr = false }, },
        ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%w\\][^%w]", register = { cr = false }, },
    },
})
require("mini.pick").setup({
    delay = { async = 1, busy = 1,},
    mappings = {
        send_to_qflist = {
            char = '<C-q>',
            func = function()
              local list = {}
              local matches = require("mini.pick").get_picker_matches().all

              for _, match in ipairs(matches) do
                if type(match) == 'table' then
                  table.insert(list, match)
                else
                  local path, lnum, col, search = string.match(match, '(.-)%z(%d+)%z(%d+)%z%s*(.+)')
                  local text = path and string.format('%s [%s:%s]  %s', path, lnum, col, search)
                  local filename =  path or vim.trim(match):match('%s+(.+)')

                  table.insert(list, {
                    filename = filename or match,
                    lnum = lnum or 1,
                    col = col or 1,
                    text = text or match,
                  })
                end
              end

              vim.fn.setqflist(list, 'r')
            end,
          },
    },
    window = {
       prompt_caret = '|',
       prompt_prefix = '> ',
    },
})
vim.keymap.set("n", "<leader>ff", MiniExtra.pickers.explorer)
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live)
vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help)
vim.keymap.set("n", "<leader>fd", MiniExtra.pickers.diagnostic)
vim.keymap.set("n", "<leader>fb", MiniExtra.pickers.buf_lines)
require("mini.icons").setup()
MiniIcons.tweak_lsp_kind()
require("mini.snippets").setup()
require("mini.splitjoin").setup({
    mappings = { toggle = 'gs', split = '', join = '', },
})
require("mini.surround").setup()
require("mini.tabline").setup()

-- Oil
require("oil").setup()
vim.keymap.set("n", "<leader>e", ":Oil<CR>")

-- Quicker
require("quicker").setup()
vim.keymap.set("n", "<leader>qf", function() require("quicker").toggle() end)
vim.keymap.set("n", ">", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end)
vim.keymap.set("n", "<", function() require("quicker").collapse() end)


-- Enable Language Servers, Autocomplete, & Diagnostics
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "ty", "ruff", "clangd" }
})


vim.diagnostic.enable()
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist)






-- Clean Unused Packages
local function pack_clean()
    local active_plugins = {}
    local unused_plugins = {}

    for _, plugin in ipairs(vim.pack.get()) do
        active_plugins[plugin.spec.name] = plugin.active
    end

    for _, plugin in ipairs(vim.pack.get()) do
        if not active_plugins[plugin.spec.name] then
            table.insert(unused_plugins, plugin.spec.name)
        end
    end

    if #unused_plugins == 0 then
        print("No unused plugins.")
        return
    end

    local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
    if choice == 1 then
        vim.pack.del(unused_plugins)
    end
end

vim.keymap.set("n", "<leader>pc", pack_clean)
