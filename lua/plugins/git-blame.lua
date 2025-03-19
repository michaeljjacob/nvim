return {
  'f-person/git-blame.nvim',
  config = function()
    vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { noremap = true, silent = true });
  end
}
