return {
	{
	  "christoomey/vim-tmux-navigator",
	  cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	  },
	  keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
	  },
	},
	"williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
	dependencies = {"williamboman/mason.nvim"},

	build = ":TSUpdate",
    event = { " BufReadPre", "BufNewFile" },
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

	"folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
}

