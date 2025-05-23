return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'nvimtools/none-ls.nvim',
    'stevearc/conform.nvim',
  },
  config = function()
    require('mason-lspconfig').setup({})

    local lspconfig = require('lspconfig')
    local null_ls = require("null-ls")
    local conform = require("conform")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.prettier,
      },
    })

    conform.setup({
      formatters_by_ft = {
        blade = { "blade-formatter" }
      },
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local on_attach = function(client, bufnr)
      local buf_set_keymap = vim.api.nvim_buf_set_keymap
      local opts = { noremap = true, silent = true }

      buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    end

    require('mason-lspconfig').setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
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
          },
          on_attach = on_attach,
        })
      end,

      ['emmet_ls'] = function()
        lspconfig.lua_ls.setup({
          on_attach = on_attach,
          capabilities = capabilities
        })
      end,

      ['intelephense'] = function()
        lspconfig.intelephense.setup({
          settings = {
            intelephense = {
              files = {
                maxSize = 5000000, -- Increase file size limit for indexing
              },
              environment = {
                phpVersion = "8.4", -- Set PHP version to 7.4
              },
              diagnostics = {
                enable = true,
              },
              completion = {
                fullyQualifyGlobalConstantsAndFunctions = false,
                triggerParameterHints = true,
              },
              indexing = {
                exclude = {
                  "**/vendor/**",
                  "**/node_modules/**",
                },
              },
              format = {
                enable = true,
              },
              inlayHints = {
                enable = false
              },
              codeLens = {
                enable = false,
              },
            },
          },
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,

      ['astro'] = function()
        lspconfig.astro.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })

    vim.lsp.set_log_level("debug")
  end
}
