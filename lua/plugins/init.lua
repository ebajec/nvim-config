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
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
				overrides = {
					-- Function arguments
					TSParameter = { fg = "#ffaf00", bold = true },
					-- Local variables
					TSVariable  = { fg = "#b8bb26"         },
				},
			})
		end
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
			  	on_colors = function(colors)
				-- Desaturate the primary blue
				colors.blue = "#606060"
				-- Tweak light and dark variants if needed
				colors.blue1 = "#7a5a6a"
				colors.blue2 = "#735263"
			  end,
			})
		end
	}
}
