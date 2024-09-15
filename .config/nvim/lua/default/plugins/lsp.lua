--[[
-- https://github.com/neovim/nvim-lspconfig
--
-- Configs for the nvim LSP client.
--]]

-- TODO: look into a more modular solution or combining all tools that require external deps here
return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install and manage external editor tools
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Autoformatting
			"stevearc/conform.nvim",

			-- LSP status updates & notifications
			{ "j-hui/fidget.nvim", opts = {} },

			-- Lua LSP for neovim config, runtime, API, plugins, ...
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			require("default.plugins.config.lsp")
		end,
	},
}
