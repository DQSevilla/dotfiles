--[[
-- Setting Standard Options
--]]

local opt = vim.opt
local g = vim.g

g.have_nerd_font = true

-- Disable health check warnings about LSP providers I don't use
g.loaded_perl_provider = false
--g.loaded_python3_provider = false

-- Line numbers & relative for easy motions
opt.number = true
opt.relativenumber = true

-- Enable mouse usage
opt.mouse = "a"

-- Don"t show the mode as it"s already in the status line
opt.showmode = false

-- Sync OS clipboard and Neovim"s
opt.clipboard = "unnamedplus"

-- Indent when line wraps around
opt.breakindent = true

-- Undo history
opt.undofile = true

-- Ignore case when searching unless \C or a capital letter is in the search term
opt.ignorecase = true
opt.smartcase = true

-- Highlight on search
opt.hlsearch = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease time to update
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how splits are opened
opt.splitright = true
opt.splitbelow = true

-- Sets how certain whitespace characters are displayed
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview %s substitutions live while typing
opt.inccommand = "split"

-- Show which line and column the cursor is on
opt.cursorline = true
opt.cursorcolumn = true

-- Minimize number of screen lines to keep below/above cursor
opt.scrolloff = 10

-- TODO: move all this and/or delete
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = false
opt.shiftround = false
