-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Colors
vim.opt.termguicolors = true

-- Autoread, reloads files changed outside nvim
vim.opt.autoread = true
vim.api.nvim_create_autocmd(
	{ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "TermLeave" },
	{
		pattern = "*",
		command = "checktime",
	}
)

-- Clipboard
vim.opt.clipboard = "unnamedplus"

