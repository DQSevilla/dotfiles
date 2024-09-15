--[[
-- Basic Keymaps
--
-- More key bindings may be setup in plugin config
--]]

local map = vim.keymap.set

-- Clear search highlight when pressing <Esc>
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
