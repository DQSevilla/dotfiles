--[[
-- https://github.com/nvim-treesitter/nvim-treesitter
--
-- Treesitter for better highlighting and advanced AST queries
--]]

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		ensure_installed = { "c", "lua", "go", "ocaml", "python" },

		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting for indent rules.
			-- Add them to this list and to indent.disable
			-- additional_vim_regex_highlighting = { "ruby" },
		},
		indent = {
			enable = true,
			-- disable = { "ruby" },
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
		-- TODO: explore additional modules
	end,
}
