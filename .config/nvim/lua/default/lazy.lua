--[[
-- Install lazy.nvim for plugin loading
--
-- Code borrowed from https://github.com/folke/lazy.nvim?tab=readme-ov-file#-installation
--]]

-- Locate/Download lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nivm"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

-- Add lazy to `runtimepath` so we can `require` it
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Setup lazy and load plugins
require("lazy").setup({ import = "default/plugins" }, {
	change_detection = { notify = false },
})
