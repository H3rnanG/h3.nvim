return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VimEnter',
  opts = {},
  keys = {
    -- Files
    { '<leader>ff', ':FzfLua files<cr>' },
    { '<leader>fb', ':FzfLua buffers<cr>' },
    { '<leader>fh', ':FzfLua oldfiles<cr>' },

    -- Search
    { '<leader>fg', ':FzfLua live_grep_native<cr>' },
    { '<leader>fc', ':FzfLua lgrep_curbuf<cr>' },

    -- Lsp
    { 'gd',         ':FzfLua lsp_definitions<cr>' },
  }
}
