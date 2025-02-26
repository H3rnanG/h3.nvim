local g = vim.g
--local o = vim.o
local opt = vim.opt
--local api = vim.api

vim.scriptencoding = 'utf8'
opt.encoding = 'utf8'
opt.fileencoding = 'utf8'
opt.tabstop = 2
opt.smartindent = true
opt.shiftwidth = 2
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes'
opt.ai = true
opt.si = true

g.mapleader = " "

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  float = { source = "always" }
})
