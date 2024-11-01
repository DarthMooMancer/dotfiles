local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('windwp/nvim-autopairs')
Plug('junegunn/fzf')
Plug('neovim/nvim-lspconfig')
Plug('nvim-treesitter/nvim-treesitter')
Plug('hrsh7th/nvim-cmp')
Plug('hrsh7th/cmp-nvim-lsp')

vim.call('plug#end')

require("plugins")
local options = {
  completeopt = { "menuone", "noselect", "noinsert", "popup" },
	shiftwidth = 2,
	expandtab = true,
	softtabstop = 2,
	tabstop = 2,
	wrap = false,
	mouse = "",
  number = true,
  relativenumber = true,
  termguicolors = true,
	autoindent = true,
  syntax = "enable",
	smartindent = true,
	scrolloff = 8,
	swapfile = false,
	backup = false,
	hlsearch = false,
	incsearch = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.mapleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-n>", vim.cmd.Ex)
vim.keymap.set("n", "<C-p>", ":FZF<CR>")

-- vim.g.mucomplete#eneable_auto_at_startup = 1
vim.cmd "set bg=dark"
vim.cmd "colorscheme quiet"
vim.cmd "highlight Keyword gui=bold"
vim.cmd "highlight Conditional gui=bold"
vim.cmd "highlight Repeat gui=bold"
vim.cmd "highlight Comment gui=italic"
vim.cmd "highlight Constant guifg=#999999"
vim.cmd "highlight NormalFloat guibg=#333331"
vim.cmd "highlight Pmenu guifg=#FFFFFF guibg=#000000"
vim.cmd "highlight StatusLine guibg=NONE guifg=#707070"