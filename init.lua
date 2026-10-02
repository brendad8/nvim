
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.neovide then
    vim.opt.guifont = "Cascadia Mono:h13"
    vim.g.neovide_cursor_animation_length = 0
end

-- options
vim.opt.cmdheight = 0
require("vim._core.ui2").enable({ enable = true })

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

vim.opt.signcolumn = "no"
vim.opt.smoothscroll = true

vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect,popup"
vim.opt.pumheight = 8

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

vim.o.undofile = true
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.autowrite = true

vim.cmd.packadd("cfilter")

vim.filetype.add({ extension = { h = "c", }, })

-- keymaps
local map = function(mode, key, cmd)
    vim.keymap.set(mode, key, cmd, { noremap = true })
end

-- tab/untab text
map("n", "<Tab>", ">>")
map("n", "<S-Tab>", "<<")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- move from windows with ctrl + hjkl
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>-", ":horiz belowr new<CR>")
map("n", "<leader>|", ":vert rightb new<CR>")

map("t", "<Esc>", [[<C-\><C-n>]])

-- move blocks of text with alt + jk
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- autocomplete
vim.opt.autocomplete = true
vim.opt.complete = { ".", "w", "b", }

vim.opt.completeopt = { "menu", "menuone", "noselect", "popup", }

vim.keymap.set("i", "<Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-n>"
    end
    return "<Tab>"
end, { expr = true })

vim.keymap.set("i", "<S-Tab>", function()
    if vim.fn.pumvisible() == 1 then
        return "<C-p>"
    end
    return "<S-Tab>"
end, { expr = true })

-- autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.hl_op()
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

-- plugins
vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/stevearc/quicker.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://codeberg.org/ziglang/zig.vim" },
})

vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

require("oil").setup()
map("n", "<leader>e", ":Oil<CR>")

local quicker = require("quicker")
quicker.setup()
map("n", "<leader>q", function() quicker.toggle() end)

require("nvim-treesitter").setup()
require("nvim-treesitter").install({ "c", "python", "zig", "lua", "odin" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "h", "py", "lua", "odin", "zig" },
    callback = function() vim.treesitter.start() end,
})

-- find files
function _G.native_find(text, _)
	local files = vim.fn.glob("**/*", true, true)
	return vim.fn.matchfuzzy(files, text)
end

-- grep
vim.opt.grepprg = "rg --vimgrep --no-messages --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

vim.keymap.set("n", "<leader>g", function()
	vim.ui.input({ prompt = "grep: " }, function(pattern)
		if pattern then
			vim.cmd("silent grep! " .. vim.fn.fnameescape(pattern))
			vim.cmd("copen")
		end
	end)
end, { silent = true })
vim.opt.findfunc = "v:lua.native_find"
vim.keymap.set("n", "<leader>f", ":find ", { silent = false })

require("colorscheme")


