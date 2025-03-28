return {
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

