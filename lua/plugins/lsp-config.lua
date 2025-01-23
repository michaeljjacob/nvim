return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "jsonls",
        "clangd",
        "denols",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        single_file_support = false,
        root_dir = function(fname)
          if (lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname) ~= nil) then
            vim.print("not starting ts lsp")
            return nil
          end
          vim.print("starting ts lsp")
          return lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git")(fname)
        end,
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })
      lspconfig.denols.setup({
        capabilities = capabilities,
        init_options = {
          lint = true,
          unstable = true,
        },
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>e", function()
        vim.diagnostic.open_float(nil, { focus = false })
      end, {})
    end,
  },
}
