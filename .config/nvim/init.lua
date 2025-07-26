vim.opt.mouse =  ""
vim.opt.completeopt = "noselect"
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.hlsearch = false
vim.opt.swapfile = false
vim.opt.clipboard = unnamedplus

vim.g.mapleader = " "
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set("n", "<leader>ff", "gg=G")
vim.keymap.set('n', '<leader><leader>', ":Telescope find_files<CR>", { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>xg', ":Telescope live_grep<CR>", { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>xh', ":Telescope help_tags<CR>", { desc = 'Telescope help tags' })
vim.keymap.set("n", "<leader>xc", "<Cmd>cclose<CR>")
vim.keymap.set("n", "<leader>xx", function()
  vim.diagnostic.setqflist({ open = true })
end, { desc = "Show diagnostics in quickfix" })

vim.cmd.colorscheme('everforest')
vim.lsp.enable({ "lua_ls", "clangd" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>:cclose<CR>", { noremap = true, silent = true })
	end,
})


vim.pack.add({
	"neovim/nvim-lspconfig",
	"nvim-treesitter/nvim-treesitter",
	"cohama/lexima.vim",
	"DarthMoomancer/Polydev",
	"nvim-telescope/telescope.nvim",
	"nvim-lua/plenary.nvim",
	{ src = "saghen/blink.cmp", version = "v1.*" },
})

require("blink.cmp").setup({
	completion = {
		ghost_text = {
			enabled = true
		}
	}
})
require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true }
})
