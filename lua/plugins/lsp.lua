return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason-lspconfig.nvim" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright" },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    require("mason-lspconfig").setup_handlers({
      function(server_name) -- Configuración por defecto
        lspconfig[server_name].setup({})
      end,

      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
          settings = {
            Lua = { diagnostics = { globals = { "vim" } } }
          }
        })
      end,
    })
  end
}
