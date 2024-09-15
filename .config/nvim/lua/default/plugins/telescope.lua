--[[
-- https://github.com/nvim-telescope/telescope.nvim
--
-- Extensible Fuzzy Finder
--]]

return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x", -- release branch (gets frequent updates)
	dependencies = {
		-- Utility functions needed by the plugin:
		"nvim-lua/plenary.nvim",

		-- Neovim core stuff can fill the Telescope picker:
		"nvim-telescope/telescope-ui-select.nvim",

		{
			-- Use a minimal performant C implementaiton of fzf:
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},

		-- Pretty icons for nerd fonts:
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },

		-- TODO: look into https://github.com/nvim-telescope/telescope-smart-history.nvim
	},
	config = function()
		require("default.plugins.config.telescope")
	end,
}
