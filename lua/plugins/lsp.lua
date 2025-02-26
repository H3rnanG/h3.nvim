return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'nvimtools/none-ls.nvim',
  },
  config = function()
    require('mason-lspconfig').setup({})
    local lspconfig = require('lspconfig')
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier,
      },
    })

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({})
      end,

      ['lua_ls'] = function()
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = {
                globals = {
                  'vim'
                }
              }
            }
          }
        })
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
}
