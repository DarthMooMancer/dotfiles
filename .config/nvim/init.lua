local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)
vim.lsp.enable({ "lua_ls", "clangd" })
vim.cmd.colorscheme('everforest')

vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.hlsearch = false
vim.opt.completeopt = { "menuone", "noselect", "popup" }

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>ff", "ggVG=")
vim.keymap.set('n', '<leader><leader>', ":Pick files<CR>")
vim.keymap.set('n', '<leader>xh', ":Pick help<CR>")
vim.keymap.set('n', '<leader>xx', ":Pick diagnostic<CR>")

require('mini.pick').setup()
require('mini.pairs').setup()
require('mini.extra').setup()
require("lazy").setup({
	spec = {
		{ "echasnovski/mini.pairs", version = '*' },
		{ 'echasnovski/mini.extra', version = '*' },
		{ "echasnovski/mini.pick", version = '*' },
		{ "saghen/blink.cmp", version = "v1.*", opts = {} },
	}
})

