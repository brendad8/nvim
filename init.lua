local vim = vim

vim.g.mapleader = " "
vim.g.maplocalleader = " "
 
vim.opt.cmdheight = 1
require("vim._core.ui2").enable({ enable = true })

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"
vim.opt.smoothscroll = true

vim.opt.showmode = false

vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect,popup"
vim.opt.pumheight = 8

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

vim.cmd.packadd("cfilter")
vim.opt.grepprg = "rg --vimgrep --no-messages --smart-case"

vim.opt.autoread = true
vim.opt.autowrite = true

-- Highlight text when copying
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = vim.api.nvim_create_augroup("resume-cursor-pos", { clear = true }),
	callback = function()
		if vim.o.diff then return end
        local last_pos = vim.api.nvim_buf_get_mark(0, '"')
        local last_line = vim.api.nvim_buf_line_count(0)
		local row = last_pos[1]
		if row < 1 or row > last_line then return end
		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

local set_hl = function(hl_name, pattern, color)
    vim.api.nvim_set_hl(0, hl_name, { fg = color, bold = true, })
    vim.fn.matchadd(hl_name, pattern)
end

set_hl("Todo", "\\<TODO\\>", "#EBCB8B")
set_hl("Note", "\\<NOTE\\>", "#61AFEF")
set_hl("Warn", "\\<WARN\\>", "#FF9E64")
set_hl("Important", "\\<IMPORTANT\\>", "#E06C75")

-- Keymaps
local map = function(mode, key, cmd)
    vim.keymap.set(mode, key, cmd, { noremap = true })
end

-- Tab/Untab text
map("n", "<Tab>", ">>")
map("n", "<S-Tab>", "<<")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- Move from windows with ctrl + hjkl
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>-", ":horiz belowr new<CR>")
map("n", "<leader>|", ":vert rightb new<CR>")

map("t", "<Esc>", [[<C-\><C-n>]])

-- Move blocks of text with alt + jk
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")



vim.keymap.set("i", "<Tab>",
    function()
        if vim.fn.pumvisible() == 1 then
            return "<C-n><C-y>"
        else
            return "<Tab>"
        end
    end,
    {expr = true}
)

-- Diagnostics
map("n", "<leader>d", vim.diagnostic.open_float)
vim.diagnostic.enable()
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Plugins
vim.pack.add({
    { src = "https://github.com/sainnhe/everforest" },
    -- { src = "https://github.com/everviolet/nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/stevearc/quicker.nvim" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/ej-shafran/compile-mode.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
})

-- vim.g.everforest_better_performance = 1
-- vim.g.everforest_background = "hard"
-- vim.cmd.colorscheme("everforest")

require("oil").setup()
map("n", "<leader>e", ":Oil<CR>")

local quicker = require("quicker")
quicker.setup()
map("n", "<leader>qf", function() quicker.toggle() end)


require("mini.ai").setup()
require("mini.cmdline").setup()
require("mini.completion").setup({
    delay = { completion = 1, info = 1, signature = 1 },
    lsp_completion = {
        source_func    = "completefunc",
        auto_setup     = true,
        process_items  = nil,
    },
    fallback_action = "<C-n>",
    window = {
        info      = { height = 25, width = 80, border = "rounded" },
        signature = { height = 25, width = 80, border = "rounded" },
    },
})
-- require("mini.icons").setup()
require("mini.operators").setup()
require("mini.pairs").setup({
    mappings = {
        [")"] = { action = "close",     pair = "()", neigh_pattern = "[^\\]." },
        ["("] = { action = "open",      pair = "()", neigh_pattern = ".[%s%z%)]",    register = { cr = false }, },
        ["]"] = { action = "close",     pair = "[]", neigh_pattern = "[^\\]." },
        ["["] = { action = "open",      pair = "[]", neigh_pattern = ".[%s%z%)}%]]", register = { cr = false }, },
        ["}"] = { action = "close",     pair = "{}", neigh_pattern = "[^\\]." },
        ["{"] = { action = "open",      pair = "{}", neigh_pattern = ".[%s%z%)}%]]", register = { cr = false }, },
        ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%w\\][^%w]", register = { cr = false }, },
        ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%w\\][^%w]", register = { cr = false }, },
    }
})
require("mini.splitjoin").setup({ mappings = {toggle = 'gj', split = '', join = ''} })
require("mini.surround").setup()
require("mini.tabline").setup({ show_icons = false })

require("telescope").setup({
    defaults = {
        layout_strategy = "horizontal",
        layout_config = { width = 0.6, height = 0.5, preview_width = 0.5 },
    },
})
local builtin = require('telescope.builtin')
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader>fs", builtin.grep_string)
map("n", "<leader>fd", builtin.diagnostics)
map("n", "<leader>fh", builtin.help_tags)

vim.g.compile_mode = {
   default_command = {
      python = "python3 ",
      c = "zig cc ",
      zig = "zig run ",
    },
}
map("n", "<leader>c", ":below Compile<CR>")
map("n", "<leader>r", ":below Recompile<CR>")

require("nvim-treesitter").setup()
require("nvim-treesitter").install({ "c", "python", "zig", "lua" })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { "c", "py", "zig", "lua" },
  callback = function() vim.treesitter.start() end,
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "lua_ls", "ty", "ruff" },
    automatic_enable = true,
})

vim.lsp.config('zls', { cmd = { "zls" } })
vim.lsp.enable('zls')


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

map("n", "<leader>pc", pack_clean)
