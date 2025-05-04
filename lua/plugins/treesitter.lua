return {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = { 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline',
                           'html', 'css', 'php', 'javascript', 'json' },

      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,

        additional_vim_regex_highlighting = false,
      },
    }

    -- Configuración del parser para Blade
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = {"src/parser.c"},
        branch = "main",
      },
      filetype = "blade"
    }

    -- Autocmd para establecer el filetype de los archivos *.blade.php
    vim.cmd [[
      augroup BladeFiltypeRelated
        autocmd!
        autocmd BufNewFile,BufRead *.blade.php set ft=blade
      augroup END
    ]]
  end
}
