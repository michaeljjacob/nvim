return {
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			ensure_installed = {
				"prettier",
				"stylua",
				--"eslint_d",
				"cspell",
			},
		},
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
			"davidmh/cspell.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			local cspell = require("cspell")
			--local eslint_d = require("none-ls.diagnostics.eslint_d")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier,
					cspell.diagnostics.with({
						diagnostics_postprocess = function(diagnostic)
							diagnostic.severity = vim.diagnostic.severity.HINT
						end,
					}),
					cspell.code_actions,
					eslint_d,
				},
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},
}
