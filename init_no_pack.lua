
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- options
vim.opt.cmdheight = 1
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

vim.opt.signcolumn = "yes"
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

-- autocommands
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

-- netrw
vim.g.netrw_liststyle = 0
vim.g.netrw_banner = 0
-- vim.g.netrw_list_hide = '^\\.'
-- vim.g.netrw_hide = 1
vim.g.netrw_sort_by = "name"
vim.g.netrw_sort_sequence = "[\\/]$,*"
vim.g.netrw_altfile = 1

vim.keymap.set("n", "<leader>e", ":Explore<cr>", { silent = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.keymap.set("n", "%", function()
			local fname = vim.fn.input("Enter filename: ")
			if fname == "" then
				return
			end

			local dir = vim.b.netrw_curdir or vim.fn.getcwd()
			local path = dir .. "/" .. fname

			if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
				vim.notify("Already exists: " .. fname, vim.log.levels.WARN)
				return
			end

			if fname:match("/$") then
				vim.fn.mkdir(path, "p")
				vim.cmd("edit")
			else
				local f = io.open(path, "w")
				if not f then
					vim.notify("Failed to create: " .. fname, vim.log.levels.ERROR)
					return
				end
				f:close()

				local escaped = vim.fn.fnameescape(path)
				if vim.fn.winnr("#") == 0 then
					vim.cmd("edit " .. escaped)
				else
					vim.cmd("wincmd p")
					vim.cmd("edit " .. escaped)
				end
			end
		end, { buffer = true, silent = true, noremap = true, desc = "Create file in previous window" })
	end,
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

-- colorscheme
vim.cmd("colorscheme catppuccin")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

local set_hl = function(hl_name, pattern, color)
    vim.api.nvim_set_hl(0, hl_name, { fg = color, bold = true, })
    vim.fn.matchadd(hl_name, pattern)
end

set_hl("Todo",      "\\<TODO\\>",      "#EBCB8B")
set_hl("Note",      "\\<NOTE\\>",      "#61AFEF")
set_hl("Warn",      "\\<WARN\\>",      "#FF9E64")
set_hl("Important", "\\<IMPORTANT\\>", "#E06C75")




