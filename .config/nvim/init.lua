local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
	"cohama/lexima.vim",
	{ "echasnovski/mini.pick", version = '*' },
	{ "saghen/blink.cmp", version = "v1.*", opts = {} },
  }
})
require('mini.pick').setup()

vim.g.mapleader = " "
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.hlsearch = false
vim.o.completeopt = { "menuone", "noselect", "popup" }

vim.lsp.enable({ "lua_ls", "clangd" })
vim.cmd.colorscheme('everforest')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>ff", "ggVG=")
vim.keymap.set('n', '<leader><leader>', ":Pick files<CR>")
