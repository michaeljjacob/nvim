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
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          require("none-ls.diagnostics.eslint_d"),
          cspell.code_actions,
          cspell.diagnostics,
        },
      })
      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  }
}
