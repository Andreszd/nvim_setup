local lsp = require('lsp-zero')
local mason = require("mason")
local mason_null_ls = require("mason-null-ls")
local null_ls = require("null-ls")

lsp.preset('recommended')

vim.opt.signcolumn = "yes"

lsp.ensure_installed({
	-- Replace these with whatever servers you want to install
	'tsserver',
	'eslint',
	'sumneko_lua',
})

-- config null ls

mason.setup()
mason_null_ls.setup({
	ensure_installed = { "stylua", "prettier", "eslint", "fixjson" },
	automatic_installation = false,
	automatic_setup = true,
})



lsp.on_attach(
	function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next, opts)
		vim.keymap.set("n", "<leader>m", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>sh", vim.lsp.buf.signature_help, opts)

	end
)

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local null_sources = {
	-- completion.spell,
	diagnostics.eslint,
	formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote" } }),
	formatting.rustfmt,
	formatting.stylua.with({ extra_args = { "--indent_type", "Spaces", "indent_width", "1" } }),
}

local function format_on_save(client, bufnr)
	if client.supports_method('textDocument/formatting') then
		vim.api.nvim_clear_autocmds({
			group = augroup,
			buffer = bufnr,
		})
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
end

null_ls.setup({
	debug = false,
	sources = null_sources,
	on_attach = format_on_save
})

-- Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
