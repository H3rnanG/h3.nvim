local km = vim.keymap

km.set('n', '<C-s>', ':w<cr>')
km.set('n', '<C-q>', ':q<cr>')

km.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
km.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
km.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
km.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

km.set('n', '+', '<C-a>')
km.set('n', '-', '<C-x>')

km.set('n', '<C-a>', 'gg<S-v>G')

km.set('n', '<leader>sh', ':split<cr><C-w>j')
km.set('n', '<leader>sv', ':vsplit<cr><C-W>l')

km.set('n', '<C-w>h', '<C-w><')
km.set('n', '<C-w>l', '<C-w>>')
km.set('n', '<C-w>k', '<C-w>+')
km.set('n', '<C-w>j', '<C-w>-')
