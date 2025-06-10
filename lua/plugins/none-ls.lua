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

      null_ls.setup({
        sources = {
          -- existing formatters
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          -- cSpell for diagnostics and code actions
          cspell.diagnostics.with({
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity.HINT
            end,
          }),
          cspell.code_actions,
        },

        -- keymap for manual formatting
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format buffer" }),
      })
    end,
  },
}
