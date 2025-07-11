-- Basic Neovim settings

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Line wrapping
vim.opt.wrap = false

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Cursor line
vim.opt.cursorline = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- clipboard
-- vim.opt.clipboard:append("unnamedplug")

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Consider hyphenated words as single words
vim.opt.iskeyword:append("-")
