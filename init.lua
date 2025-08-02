local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
vim.opt.number = true
vim.opt.relativenumber = true
--plugins
require("lazy").setup({
	spec = {
		{import = "plugins"}
	}
})

require("mason").setup()

-- need to run this after mason setup
require("dap-setup").setup()
require("cmp-setup").setup()
require("lsp-setup").setup()

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

local keyopts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader><Space>', ":NvimTreeToggle<CR>", keyopts)

vim.keymap.set('n', 'tn', ':tabnew<CR>', keyopts)

vim.cmd([[colorscheme tokyonight]])

