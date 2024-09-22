--[[
-- Configuration for LSP and other code intelligence plugins.
--]]

-- Extend LSP Client capabilities with functionality from plugins
local capabilities = vim.lsp.protocol.make_client_capabilities()
if pcall(require, "cmp_nvim_lsp") then
	-- stylua: ignore
	capabilities = vim.tbl_deep_extend(
		"force",
		{},
		capabilities,
		require("cmp_nvim_lsp").default_capabilities()
	)
end

-- Language servers and their settings
local servers = {
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				completion = { callSnippet = "Replace" },
			},
		},
	},
	gopls = {
		settings = {
			gopls = {
				gofumpt = true,
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	},
}

-- Language formatters
local formatters_by_ft = {
	lua = { "stylua" },
	go = { "gofumpt", "goimports", "goimports-reviser" },
}

-- Ensuring servers and tools are installed. See :Mason
require("mason").setup()

local ensure_installed = {}
for _, tools in pairs(formatters_by_ft) do
	for _, tool in ipairs(tools) do
		table.insert(ensure_installed, tool)
	end
end

vim.list_extend(ensure_installed, vim.tbl_keys(servers or {}))
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}

			-- Server-specific overrides to LSP capabilities
			-- stylua: ignore
			server.capabilities = vim.tbl_deep_extend(
				"force",
				{},
				capabilities,
				server.capabilities or {}
			)
			require("lspconfig")[server_name].setup(server)
		end,
	},
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		-- TODO: more mappings
		local mappings = {
			{
				keys = "gd",
				telescopeFunc = require("telescope.builtin").lsp_definitions,
				fallbackFunc = vim.lsp.buf.definition,
				desc = "[G]oto [D]efinition",
			},
			{
				keys = "gD",
				fallbackFunc = vim.lsp.buf.declaration,
				desc = "[G]oto [D]eclaration",
			},
			{
				keys = "gr",
				telescopeFunc = require("telescope.builtin").lsp_references,
				fallbackFunc = vim.lsp.buf.references,
				desc = "[G]oto [R]eferences",
			},
			{
				-- useful for languages that declare types without implementations
				keys = "gI",
				telescopeFunc = require("telescope.builtin").lsp_implementations,
				fallbackFunc = vim.lsp.buf.implementation,
				desc = "[G]oto [I]mplementation",
			},
			-- TODO: trouble.nvim?
			-- FIXME: I feel like the following should be default behavior...
			{
				keys = "]d",
				fallbackFunc = function() -- TODO: same but for [d?
					vim.diagnostic.goto_next()
					vim.diagnostic.open_float()
				end,
				desc = "Jump to next [d]iagnostic",
			},
			{
				keys = "[d",
				fallbackFunc = function()
					vim.diagnostic.goto_prev()
					vim.diagnostic.open_float()
				end,
				desc = "Jump to next [d]iagnostic",
			},
			{
				keys = "<leader>D",
				telescopeFunc = require("telescope.builtin").lsp_type_definitions,
				fallbackFunc = vim.lsp.buf.type_definition,
				desc = "Type [D]efinitions",
			},
			{
				-- fuzzy find all symbols in current document
				keys = "<leader>ds",
				telescopeFunc = require("telescope.builtin").lsp_document_symbols,
				fallbackFunc = vim.lsp.buf.document_symbol,
				desc = "[D]ocument [S]earch",
			},
			{
				-- fuzzy finmd all symbols in current workspace
				keys = "<leader>ws",
				telescopeFunc = require("telescope.builtin").lsp_dynamic_workspace_symbols,
				fallbackFunc = vim.lsp.buf.workspace_symbol,
				desc = "[W]orkspace [S]earch",
			},
			{
				-- rename accross files
				keys = "<leader>rn",
				fallbackFunc = vim.lsp.buf.rename,
				desc = "[R]e[n]ame",
			},
			{
				-- execute a code action
				keys = "<leader>ca",
				fallbackFunc = vim.lsp.buf.code_action,
				desc = "[C]ode [A]ction",
			},
			{
				keys = "K",
				fallbackFunc = vim.lsp.buf.hover,
				desc = "Hover Documentation",
			},
		}

		-- buffer-specific keymap for when LSP attached
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Map to the better telescope equivalents when possible:
		local have_telescope = pcall(require, "telescope.builtin")
		for _, m in ipairs(mappings) do
			local f = m.fallbackFunc
			if have_telescope and m.telescopeFunc then
				f = m.telescopeFunc
			end

			map(m.keys, f, m.desc)
		end

		local client = assert(vim.lsp.get_client_by_id(event.data.client_id), "must have valid LSP client")

		-- Highlight references of word under cursor, and clear them when moving the cursor:
		if client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				callback = vim.lsp.buf.clear_references,
			})
		end
	end,
})

if pcall(require, "conform") then
	require("conform").setup({
		notify_on_error = false,
		format_on_save = function(bufnr)
			-- disable format_on_save lsp_fallback for languages without
			-- a standard coding style:
			local disable_filetypes = { c = true, cpp = true }
			return {
				bufnr = bufnr,
				timeout_ms = 500,
				lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
			}
		end,
		formatters_by_ft = formatters_by_ft,
	})
end
