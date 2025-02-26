return {
  'adalessa/laravel.nvim',
  dependencies = {
    'tpope/vim-dotenv',
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
    'kevinhwang91/promise-async',
  },
  cmd = { 'Laravel' },
  keys = {
    {
      '<leader>la',
      mode = 'n',
      ':Laravel artisan<cr>',
      desc = 'Laravel artisan'
    },
    {
      '<leader>lr',
      mode = 'n',
      ':Laravel routes<cr>',
      desc = 'Laravel routes'
    },
    {
      '<leader>lm',
      mode = 'n',
      ':Laravel related<cr>',
      desc = 'Laravel related'
    },
    {
      '<leader>lh',
      mode = 'n',
      ':Laravel history<cr>',
      desc = 'Laravel history'
    },
  },
  event = { 'VeryLazy' },
  opts = {},
  config = true,
}
