vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

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

    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
})

-- mason

require("mason").setup()
require("mason-lspconfig").setup()

-- completion
local cmp = require("cmp")
cmp.setup({
	autocomplete = true,
    snippet = {
        expand = function(args)
        	require("luasnip").lsp_expand(args.body)
        end,
    },
	mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, 	 {
        { name = "buffer" },
    }),
})

require("lsp_signature").setup({})


-- lint

require("nvim-treesitter.configs").setup({
	ensure_installed = {"c","cpp","glsl","lua","vim","vimdoc","query","markdown","markdown_inline"},
	auto_install = true,
	highlight = { enable = true},
	indent = {enable = true},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			node_decremental = "<bs>"
		},
	},
})

-- debugger

require("dap-config")

require("mason-nvim-dap").setup({
	ensure_installed = {
		"cppdbg"
	},
	automatic_installation = true,
})
require("dapui").setup({
	layouts = {
	{
		elements = { "scopes", "breakpoints", "stacks", "watches" },
	      	size = 40,
	      	position = "left",
	},
	{
	      elements = { "repl" },
	      size = 0.25, -- 25% of total lines
	      position = "bottom",
	},
	},
})
require("nvim-dap-virtual-text").setup({
	enabled = true
})

-- lsp 
local capabilities = vim.lsp.protocol.make_client_capabilities()

require("lspconfig").cmake.setup {}
require("lspconfig").lua_ls.setup {
	settings = {
    	Lua = {
      		diagnostics = {
        			globals = { "vim" },
      			},
    		},
  	},
}
require("lspconfig").clangd.setup {
	capabilities = capabilites,
	on_attach = function(client,bufnr)
		local opts = {noremap = true, silent = false}
		local buf_set_keymap = vim.api.nvim_buf_set_keymap

		buf_set_keymap(bufnr, "n", "gd","<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		buf_set_keymap(bufnr, "n", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	end
}

require('lspconfig').glslls.setup{}

vim.cmd[[colorscheme tokyonight]]

