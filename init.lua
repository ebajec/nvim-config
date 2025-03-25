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

--plugins
require("lazy").setup({
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "neovim/nvim-lspconfig",

    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { " BufReadPre", "BufNewFile" },

    "hrsh7th/cmp-nvim-lsp",   -- LSP source
    "hrsh7th/cmp-buffer",     -- Buffer source
    "hrsh7th/cmp-path",       -- Path source
    "hrsh7th/cmp-cmdline",    -- Command line source
    "L3MON4D3/LuaSnip",       -- Snippet engine
    "saadparwaiz1/cmp_luasnip", -- LuaSnip source for cmp
	"hrsh7th/nvim-cmp",
	{
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	opts = {
		bind=true,
		handler_opts = {
      		border = "rounded"
    		}
		},
	},
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
	{
	  "lewis6991/gitsigns.nvim",
	  lazy = true,
	  event = { "BufReadPre", "BufNewFile" },
	  config = function()
		require("gitsigns").setup({
		  signs = {
			add          = { text = "│" },
			change       = { text = "│" },
			delete       = { text = "_" },
			topdelete    = { text = "‾" },
			changedelete = { text = "~" },
		  },
		  current_line_blame = false, -- set to true if you want inline blame info
		})
	  end,
	},
	{
	  "nvim-tree/nvim-tree.lua",
	  dependencies = { "nvim-tree/nvim-web-devicons" },
	  opts = {
		disable_netrw = true,
		hijack_netrw  = true,
		view = {
		  side = "left",
		  width = 30,
		},
	  },
	},

	{
	"folke/trouble.nvim",
	  opts = {},
	  cmd = "Trouble",
	  keys = {
		{
		  "<leader>xx",
		  "<cmd>Trouble diagnostics toggle<cr>",
		  desc = "Diagnostics (Trouble)",
		},
		{
		  "<leader>xX",
		  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		  desc = "Buffer Diagnostics (Trouble)",
		},
		{
		  "<leader>cs",
		  "<cmd>Trouble symbols toggle focus=false<cr>",
		  desc = "Symbols (Trouble)",
		},
		{
		  "<leader>cl",
		  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		  desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
		  "<leader>xL",
		  "<cmd>Trouble loclist toggle<cr>",
		  desc = "Location List (Trouble)",
		},
		{
		  "<leader>xQ",
		  "<cmd>Trouble qflist toggle<cr>",
		  desc = "Quickfix List (Trouble)",
		},
	  },
	},

    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
})

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
vim.keymap.set('n', '<leader>f', ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
vim.keymap.set('n', 'tn', ':tabnew<CR>', { noremap = true, silent = true })

-- mason
require("mason").setup()

require("dap-setup")
require("lsp-setup")
require("treesitter-setup")
require("cmp-setup")

vim.cmd[[colorscheme tokyonight]]

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { max_width = smart_width() }
)

