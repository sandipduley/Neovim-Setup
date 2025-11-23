return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jayp0521/mason-null-ls.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		require("mason-null-ls").setup({
			ensure_installed = {
				"checkmake",
				"prettier",
				"eslint_d",
				"shfmt",
				"stylua",
				"ruff",
				"gofmt",
				"goimports",
				"golangci_lint",
				"shellcheck",
				"sqlfluff",
			},
			automatic_installation = true,
		})

		local sources = {
			diagnostics.checkmake,

			-- JS / TS / React / Node / Express / Mongo
			formatting.prettier.with({
				filetypes = {
					"html",
					"json",
					"yaml",
					"markdown",
					"javascript",
					"javascriptreact",
					"typescript",
					"typescriptreact",
					"css",
					"scss",
					"vue",
					"svelte",
				},
			}),
			diagnostics.eslint_d,

			-- Lua
			formatting.stylua,

			-- Shell
			formatting.shfmt.with({ args = { "-i", "4" } }),
			diagnostics.shellcheck,

			-- Python
			require("none-ls.formatting.ruff").with({ extra_args = { "--extend-select", "I" } }),
			require("none-ls.formatting.ruff_format"),

			-- Go
			formatting.gofmt,
			formatting.goimports,
			diagnostics.golangci_lint,

			-- SQL
			formatting.sqlfluff.with({ extra_args = { "--dialect", "mysql" } }),
			diagnostics.sqlfluff,
		}

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = sources,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end
			end,
		})
	end,
}
