--[[
-- Basic autocmds
--]]

local ftgroup = vim.api.nvim_create_augroup("ft_indent", { clear = false })

vim.api.nvim_create_autocmd("FileType", {
	desc = "Default to 4 spaces for certain file types",
	group = ftgroup,
	pattern = { "python", "java", "c", "cpp", "erlang", "bazel", "bzl", "skylark", "starlark" },
	command = "setlocal ts=4 sw=4 sts=4 expandtab",
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Default to standard 4-space-width tabs for certain file types",
	group = ftgroup,
	pattern = { "make", "go" },
	command = "setlocal ts=4 sw=4 sts=0",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	desc = "Trim whitespace from line endings upon saving",
	pattern = "*",
	command = [[ :%s/\s\+$//e ]],
})

local higroup = vim.api.nvim_create_augroup("hi_group", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = higroup,
	callback = function()
		vim.highlight.on_yank()
	end,
})
