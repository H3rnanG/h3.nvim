return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local opts = { noremap = true, silent = true }

    require("toggleterm").setup({
      direction = "float",
      float_opts = {
        border = "curved",
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
      },
    })

    local function open_terminal(id)
      vim.cmd("ToggleTerm " .. id)
    end

    vim.keymap.set('n', '<C-/>', '<cmd>ToggleTerm<CR>', opts)
    vim.keymap.set('t', '<C-/>', '<cmd>ToggleTerm<CR>', opts)

    for i = 1, 9 do
      vim.keymap.set('n', i .. '<C-/>', function() open_terminal(i) end, opts)
      vim.keymap.set('t', i .. '<C-/>', function() open_terminal(i) end, opts)
    end

    vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
  end,
}
