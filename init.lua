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
require("lazy").setup("plugins")

require("mason").setup()

-- need to run this after mason setup
require("dap-setup").setup()
require("cmp-setup").setup()

local function smart_width()
  return math.floor(vim.o.columns * 0.5)
end

vim.diagnostic.config({
	virtual_text = true,
	float = {
		wrap = true,
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
		max_width = smart_width(),
	},
})
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.keymap.set('n', '<leader>ghb', function() require("gitsigns").blame_line({ full = true }) end)
vim.keymap.set('n', '<leader>ghB', function() require("gitsigns").blame() end)

vim.keymap.set('n', '<leader><Space>', ":NvimTreeToggle<CR>", { noremap = true, silent = true })

local keyopts = { noremap = true, silent = true }

vim.keymap.set('n', 'tn', ':tabnew<CR>', keyopts)

vim.cmd[[colorscheme tokyonight]]

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { max_width = smart_width() }
)

