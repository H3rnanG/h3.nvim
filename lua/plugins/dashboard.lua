return {
  'nvimdev/dashboard-nvim',
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            desc = 'Update',
            group = '@property',
            action = 'Lazy update',
            key = 'u'
          },
          {
            icon_hl = '@variable',
            desc = 'Find files',
            group = 'Label',
            action = 'FzfLua files',
            key = 'f',
          },
          {
            icon_hl = '@variable',
            desc = 'NeoTree',
            group = 'Label',
            action = 'Neotree',
            key = 'e',
          },
        },
      },
    }
  end
}
