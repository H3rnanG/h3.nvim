return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>e',
      mode = 'n',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    {
      '<leader>E',
      mode = 'n',
      '<cmd>Yazi cwd<cr>',
      desc = 'Open the file manager in nvim working directory',
    },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
    float = {
      border = "rounded",
      highlight = "NormalFloat",
    }
  },
}
